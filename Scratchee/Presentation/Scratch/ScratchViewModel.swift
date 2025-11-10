import Combine

@MainActor
final class ScratchViewModel: ObservableObject {
    @Published var isScratching = false
    private var task: Task<Void, Never>? = nil

    private let scratchUseCase: ScratchCardUseCase
    private let onClose: () -> Void

    init(
        scratchUseCase: ScratchCardUseCase,
        onClose: @escaping () -> Void
    ) {
        self.scratchUseCase = scratchUseCase
        self.onClose = onClose
    }

    func scratch() {
        guard !isScratching else { return }

        isScratching = true
        task = Task {
            await scratchUseCase.run()
            await MainActor.run {
                self.isScratching = false

                if !Task.isCancelled {
                    self.onClose()
                }
            }
        }
    }

    func cancel() {
        task?.cancel()
        task = nil
    }
}
