import Foundation
@testable import Scratchee

actor ObserveCardStateUseCaseSpy: ObserveCardStateUseCase {
    private(set) var callCount = 0
    private var continuation: AsyncStream<CardState>.Continuation?

    func run() async -> AsyncStream<CardState> {
        callCount += 1

        return AsyncStream { cont in
            continuation = cont
        }
    }

    func emit(_ state: CardState) {
        continuation?.yield(state)
    }

    func finish() {
        continuation?.finish()
    }
}
