@testable import Scratchee
import XCTest

final class CardsRepositoryLiveTests: XCTestCase {
    func test_givenInitialState_whenObserving_thenEmitsUnscratchedImmediately() async {
        let sut = makeSUT()
        let stream = await sut.observeState()
        var iterator = stream.makeAsyncIterator()

        let first = await iterator.next()

        XCTAssertEqual(first, .unscratched)
    }

    func test_givenSetStateCalled_whenObserving_thenEmitsNewState() async {
        let sut = makeSUT()
        let stream = await sut.observeState()
        var iterator = stream.makeAsyncIterator()

        _ = await iterator.next()

        await sut.setState(.activated)
        let next = await iterator.next()

        XCTAssertEqual(next?.isActivated, true)
    }

    func test_givenMultipleStateChanges_whenObserving_thenEmitsAllInOrder() async {
        let sut = makeSUT()
        let stream = await sut.observeState()
        var iterator = stream.makeAsyncIterator()

        _ = await iterator.next()

        let code = UUID()

        await sut.setState(.scratched(code: code))
        let first = await iterator.next()

        await sut.setState(.activated)
        let second = await iterator.next()

        XCTAssertEqual(first, .scratched(code: code))
        XCTAssertEqual(second, .activated)
    }

    func test_givenScratch_whenCalled_thenReturnsUUID() async throws {
        let sut = makeSUT()

        let result = try await sut.scratch()

        XCTAssertNotNil(result.uuidString)
        XCTAssertEqual(result.uuidString.count, 36)
    }

    private func makeSUT() -> CardsRepositoryLive {
        CardsRepositoryLive()
    }
}

private extension CardState {
    var isActivated: Bool {
        if case .activated = self { return true }
        return false
    }
}
