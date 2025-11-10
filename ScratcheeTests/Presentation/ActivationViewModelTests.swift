import XCTest
@testable import Scratchee

@MainActor
final class ActivationViewModelTests: XCTestCase {

    func test_givenInitialState_whenActivate_thenSetsLoadingState() async {
        let activateSpy = ActivateCardUseCaseSpy()
        let closeSpy = ClosureSpy()
        let sut = makeSUT(activateSpy: activateSpy, closeSpy: closeSpy)

        XCTAssertFalse(sut.isLoading)

        await sut.activate()

        XCTAssertFalse(sut.isLoading)
    }

    func test_givenActivateCalled_whenRunCompletes_thenUseCaseInvokedOnce() async {
        let activateSpy = ActivateCardUseCaseSpy()
        let closeSpy = ClosureSpy()
        let sut = makeSUT(activateSpy: activateSpy, closeSpy: closeSpy)

        await sut.activate()

        let calls = await activateSpy.callCount
        XCTAssertEqual(calls, 1)
    }

    func test_givenActivateCompletes_whenRunFinishes_thenOnCloseIsCalled() async {
        let activateSpy = ActivateCardUseCaseSpy()
        let closeSpy = ClosureSpy()
        let sut = makeSUT(activateSpy: activateSpy, closeSpy: closeSpy)

        await sut.activate()

        XCTAssertEqual(closeSpy.callCount, 1)
    }

    func test_givenAlreadyLoading_whenActivateCalledAgain_thenDoesNotInvokeUseCase() async {
        let activateSpy = ActivateCardUseCaseSpy()
        let closeSpy = ClosureSpy()
        let sut = makeSUT(activateSpy: activateSpy, closeSpy: closeSpy)

        sut.isLoading = true

        await sut.activate()

        let calls = await activateSpy.callCount
        XCTAssertEqual(calls, 0)
    }

    private func makeSUT(
        activateSpy: ActivateCardUseCaseSpy,
        closeSpy: ClosureSpy
    ) -> ActivationViewModel {
        ActivationViewModel(
            activateUseCase: activateSpy,
            onClose: { closeSpy.call() }
        )
    }
}
