import XCTest
@testable import Scratchee

final class ScratchCardUseCaseTests: XCTestCase {
    func test_givenScratchStarts_whenRun_thenSetsScratchingAndScratched() async {
        let cardsSpy = CardsRepositorySpy()
        let sut = makeSUT(cardsRepository: cardsSpy)

        await sut.run()

        let states = await cardsSpy.receivedStates()
        XCTAssertEqual(states.count, 2)

        XCTAssertEqual(states[0], .scratching)

        if case .scratched(let code) = states[1] {
            XCTAssertNotNil(code)
        } else {
            XCTFail("Expected .scratched(_)")
        }
    }

    func test_givenTaskIsCancelled_whenRun_thenStopsAfterScratchingState() async {
        let cardsSpy = CardsRepositorySpy()
        let sut = makeSUT(cardsRepository: cardsSpy)

        let task = Task {
            await sut.run()
        }

        task.cancel()
        await task.value

        let states = await cardsSpy.receivedStates()
        XCTAssertEqual(states.count, 1)
        XCTAssertEqual(states[0], .scratching)
    }

    func test_givenErrorOccurs_whenRun_thenSetsErrorState() async {
        let cardsSpy = CardsRepositorySpy()
        let sut = makeSUT(cardsRepository: cardsSpy)

        await cardsSpy.configureScratch { throw TestError.fail }

        await sut.run()

        let states = await cardsSpy.receivedStates()
        XCTAssertEqual(states.count, 2)
        XCTAssertEqual(states[0], .scratching)

        if case .error(let message) = states[1] {
            XCTAssertEqual(message, "Scratch failed")
        } else {
            XCTFail("Expected .error(message:)")
        }
    }

    private func makeSUT(cardsRepository: CardsRepository) -> ScratchCardUseCase {
        ScratchCardUseCaseLive(cardsRepository: cardsRepository)
    }
}

private enum TestError: Error { case fail }
