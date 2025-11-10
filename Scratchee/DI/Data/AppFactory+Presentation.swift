extension AppFactory {
    func makeHomeView(
        onScratch: @escaping () -> Void,
        onActivate: @escaping () -> Void
    ) -> HomeView {
        HomeView(
            viewModel: HomeViewModel(
                observeCardState: self.observeCardStateUseCase,
                onActivate: onActivate,
                onScratch: onScratch
            )
        )
    }

    func makeActivationView(onClose: @escaping () -> Void) -> ActivationView {
        ActivationView(
            viewModel: ActivationViewModel(
                activateUseCase: self.activateCardUseCase,
                onClose: onClose
            )
        )
    }

    func makeScratchView(onClose: @escaping () -> Void) -> ScratchView {
        ScratchView(
            viewModel: ScratchViewModel(
                scratchUseCase: self.scratchCardUseCase,
                onClose: onClose
            )
        )
    }
}
