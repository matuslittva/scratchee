import XCTest
@testable import Scratchee

@MainActor
final class ScratchViewModelTests: XCTestCase {

    func test_givenScratchStarts_whenRun_thenSetsIsScratchingTrue() {
        let spy = ScratchUseCaseSpy()
        let sut = makeSUT(scratchUseCase: spy)

        sut.scratch()

        XCTAssertTrue(sut.isScratching)
    }

    func test_givenScratchFinishes_whenRun_thenSetsIsScratchingFalseAndCallsOnClose() async {
        var onCloseCount = 0
        let spy = ScratchUseCaseSpy()
        let sut = makeSUT(scratchUseCase: spy, onClose: { onCloseCount += 1 })

        sut.scratch()

        try? await Task.sleep(for: .milliseconds(10))

        let calls = await spy.callCount
        XCTAssertEqual(calls, 1)
        XCTAssertFalse(sut.isScratching)
        XCTAssertEqual(onCloseCount, 1)
    }

    func test_givenScratchCancelled_whenRun_thenDoesNotCallOnClose() async {
        var onCloseCount = 0
        let spy = ScratchUseCaseSpy()
        let sut = makeSUT(scratchUseCase: spy, onClose: { onCloseCount += 1 })

        sut.scratch()

        sut.cancel()
        try? await Task.sleep(for: .milliseconds(10))

        XCTAssertEqual(onCloseCount, 0)
        XCTAssertFalse(sut.isScratching)
    }

    func test_givenScratchCancelled_whenRun_thenDoesNotFinishScratch() async {
        let longScratchSpy = ScratchUseCaseSpy(sleepDuration: .seconds(1))
        let sut = makeSUT(scratchUseCase: longScratchSpy)

        sut.scratch()
        sut.cancel()

        try? await Task.sleep(for: .milliseconds(10))

        let calls = await longScratchSpy.callCount
        let wasCancelled = await longScratchSpy.wasCancelled
        XCTAssertEqual(calls, 1)
        XCTAssertFalse(sut.isScratching)
        XCTAssertTrue(wasCancelled)
    }

    private func makeSUT(
        scratchUseCase: ScratchUseCaseSpy,
        onClose: @escaping () -> Void = {}
    ) -> ScratchViewModel {
        ScratchViewModel(
            scratchUseCase: scratchUseCase,
            onClose: onClose
        )
    }
}
