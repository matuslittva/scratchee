import Combine

@MainActor
final class ActivationViewModel: ObservableObject {
    @Published var isLoading = false

    private let activateUseCase: ActivateCardUseCase
    private let onClose: () -> Void

    init(
        activateUseCase: ActivateCardUseCase,
        onClose: @escaping () -> Void
    ) {
        self.activateUseCase = activateUseCase
        self.onClose = onClose
    }

    func activate() async {
        guard !isLoading else { return }
        isLoading = true

        await activateUseCase.run()

        isLoading = false
        onClose()
    }
}
