extension AppFactory {
    var observeCardStateUseCase: ObserveCardStateUseCase {
        ObserveCardStateUseCaseLive(cardsRepository: cardsRepository)
    }

    var activateCardUseCase: ActivateCardUseCase {
        ActivateCardUseCaseLive(
            versionRepository: versionRepository,
            cardsRepository: cardsRepository
        )
    }

    var scratchCardUseCase: ScratchCardUseCase {
        ScratchCardUseCaseLive(cardsRepository: cardsRepository)
    }
}
