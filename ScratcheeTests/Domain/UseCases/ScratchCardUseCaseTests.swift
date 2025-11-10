import XCTest
@testable import Scratchee

final class ScratchCardUseCaseTests: XCTestCase {
    func test_givenScratchSucceeds_whenRun_thenSetsScratchedState() async {
        let cardsSpy = CardsRepositorySpy()
        let sut = makeSUT(cardsRepository: cardsSpy)

        await sut.run()

        let states = await cardsSpy.receivedStates()
        XCTAssertEqual(states.count, 1)

        if case .scratched(let code) = states[0] {
            XCTAssertNotNil(code)
        } else {
            XCTFail("Expected .scratched(_)")
        }
    }

    func test_givenTaskIsCancelled_whenRun_thenDoesNotChangeState() async {
        let cardsSpy = CardsRepositorySpy()
        await cardsSpy.configureScratch {
            try await Task.sleep(for: .seconds(2))
            return UUID()
        }
        let sut = makeSUT(cardsRepository: cardsSpy)
        
        let task = Task {
            await sut.run()
        }

        task.cancel()
        _ = await task.result

        let states = await cardsSpy.receivedStates()
        XCTAssertEqual(states.count, 0)
    }

    func test_givenErrorOccurs_whenRun_thenSetsErrorState() async {
        let cardsSpy = CardsRepositorySpy()
        await cardsSpy.configureScratch { throw TestError.fail }

        let sut = makeSUT(cardsRepository: cardsSpy)

        await sut.run()

        let states = await cardsSpy.receivedStates()
        XCTAssertEqual(states.count, 1)

        if case .error(let message) = states[0] {
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
