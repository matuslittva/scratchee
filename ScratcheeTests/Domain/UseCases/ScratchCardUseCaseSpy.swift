import Foundation
@testable import Scratchee

final actor ScratchUseCaseSpy: ScratchCardUseCase {
    private let sleepDuration: Duration?
    private(set) var callCount = 0
    private(set) var wasCancelled = false

    init(sleepDuration: Duration? = nil) {
        self.sleepDuration = sleepDuration
    }

    func run() async {
        callCount += 1
        if let duration = sleepDuration {
            do {
                try await Task.sleep(for: duration)
            } catch {
                wasCancelled = true
                return
            }
        }
    }
}
