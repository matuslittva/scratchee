extension AppFactory {
    func makeActivationView(onClose: @escaping () -> Void) -> ActivationView {
        ActivationView(
            viewModel: ActivationViewModel(
                activateUseCase: self.activateCardUseCase,
                onClose: onClose
            )
        )
    }
}
