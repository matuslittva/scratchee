protocol ObserveCardStateUseCase: Sendable {
    func run() async -> AsyncStream<CardState>
}

struct ObserveCardStateUseCaseLive: ObserveCardStateUseCase {
    let cardsRepository: CardsRepository

    func run() async -> AsyncStream<CardState> {
        await cardsRepository.observeState()
    }
}
