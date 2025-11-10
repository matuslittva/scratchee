import XCTest
@testable import Scratchee

final class ActivateCardUseCaseTests: XCTestCase {
    func test_givenVersionAboveThreshold_whenRun_thenSetsActivated() async {
        let code = UUID()
        let cardsSpy = CardsRepositorySpy(initial: .scratched(code: code))
        let versionSpy = VersionRepositorySpy { Version("6.24") }
        let sut = makeSUT(versionRepository: versionSpy, cardsRepository: cardsSpy)

        await sut.run(code: code)

        let states = await cardsSpy.receivedStates()
        XCTAssertEqual(versionSpy.callCount, 1)
        XCTAssertEqual(states.last, .activated)
    }

    func test_givenVersionBelowThreshold_whenRun_thenSetsError() async {
        let code = UUID()
        let cardsSpy = CardsRepositorySpy(initial: .scratched(code: code))
        let versionSpy = VersionRepositorySpy { Version("5.9") }
        let sut = makeSUT(versionRepository: versionSpy, cardsRepository: cardsSpy)

        await sut.run(code: code)

        let states = await cardsSpy.receivedStates()
        XCTAssertEqual(versionSpy.callCount, 1)
        XCTAssertEqual(states.last, .error(message: "Activation failed"))
    }

    func test_givenRepositoryThrows_whenRun_thenSetsNetworkError() async {
        let code = UUID()
        let cardsSpy = CardsRepositorySpy(initial: .scratched(code: code))
        let versionSpy = VersionRepositorySpy { throw URLError(.badServerResponse) }
        let sut = makeSUT(versionRepository: versionSpy, cardsRepository: cardsSpy)

        await sut.run(code: code)

        let states = await cardsSpy.receivedStates()
        XCTAssertEqual(versionSpy.callCount, 1)
        XCTAssertEqual(states.last, .error(message: "Network error"))
    }

    private func makeSUT(
        versionRepository: VersionRepository,
        cardsRepository: CardsRepository
    ) -> ActivateCardUseCase {
        ActivateCardUseCaseLive(
            versionRepository: versionRepository,
            cardsRepository: cardsRepository
        )
    }
}
