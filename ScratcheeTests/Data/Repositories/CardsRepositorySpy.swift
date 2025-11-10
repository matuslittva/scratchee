import Foundation
@testable import Scratchee

actor CardsRepositorySpy: CardsRepository {
    private var state: CardState
    private var states: [CardState] = []

    private var scratchBehavior: () async throws -> UUID

    init(
        initial: CardState = .unscratched,
        scratchBehavior: @escaping () async throws -> UUID = { UUID() }
    ) {
        self.state = initial
        self.scratchBehavior = scratchBehavior
    }

    func configureScratch(_ behavior: @escaping () async throws -> UUID) {
        scratchBehavior = behavior
    }

    func observeState() async -> AsyncStream<CardState> {
        AsyncStream { $0.yield(state) }
    }

    func currentState() async -> CardState { state }

    func scratch() async throws -> UUID {
        try await scratchBehavior()
    }

    func setState(_ new: CardState) async {
        state = new
        states.append(new)
    }

    func receivedStates() async -> [CardState] {
        states
    }
}
