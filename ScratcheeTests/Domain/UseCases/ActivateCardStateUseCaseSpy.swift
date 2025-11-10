import Foundation
@testable import Scratchee

final actor ActivateCardUseCaseSpy: ActivateCardUseCase {
    private(set) var callCount = 0

    func run() async {
        callCount += 1
    }
}
