import XCTest
@testable import Scratchee

final class ObserveCardStateUseCaseTests: XCTestCase {
    func test_givenInitialState_whenRun_thenReceivesInitialState() async {
        let spy = CardsRepositorySpy(initial: .unscratched)
        let sut = makeSUT(cardsRepository: spy)

        let stream = await sut.run()
        var iterator = stream.makeAsyncIterator()
        let first = await iterator.next()

        XCTAssertEqual(first, .unscratched)
    }

    func test_givenStateChanges_whenObserved_thenReceivesStatesInOrder() async {
        let spy = CardsRepositorySpy(initial: .unscratched)
        let sut = makeSUT(cardsRepository: spy)

        let _ = await sut.run()

        await spy.setState(.scratching)
        let code = UUID()
        await spy.setState(.scratched(code: code))

        let states = await spy.receivedStates()
        XCTAssertEqual(states, [
            .scratching,
            .scratched(code: code)
        ])
    }

    private func makeSUT(cardsRepository: CardsRepository) -> ObserveCardStateUseCase {
        ObserveCardStateUseCaseLive(cardsRepository: cardsRepository)
    }
}
