import Foundation

protocol CardsRepository: Sendable {
    func observeState() async -> AsyncStream<CardState>
    func currentState() async -> CardState
    func scratch() async throws -> UUID
    func setState(_ state: CardState) async
}
