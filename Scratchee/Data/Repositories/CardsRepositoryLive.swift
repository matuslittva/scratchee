import Foundation

final actor CardsRepositoryLive: CardsRepository {
    private var stateContinuation: AsyncStream<CardState>.Continuation?
    private var state: CardState = .unscratched {
        didSet { stateContinuation?.yield(state) }
    }

    func observeState() async -> AsyncStream<CardState> {
        AsyncStream { continuation in
            stateContinuation = continuation
            continuation.yield(state)
        }
    }

    func currentState() async -> CardState {
        state
    }

    func scratch() async throws -> UUID {
        try await Task.sleep(for: .seconds(2))
        return UUID()
    }

    func setState(_ new: CardState) async {
        state = new
    }
}
