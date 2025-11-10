import Foundation
@testable import Scratchee

final actor ScratchCardUseCaseSpy: ScratchCardUseCase {
    private(set) var callCount = 0

    func run() async {
        callCount += 1
    }
}
