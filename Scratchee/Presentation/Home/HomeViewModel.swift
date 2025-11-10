import Combine
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var cardState: CardState = .unscratched
    var isActivatable: Bool {
        if case .scratched = cardState { return true }
        return false
    }

    private let observeCardState: ObserveCardStateUseCase
    private let onActivate: () -> Void
    private let onScratch: () -> Void

    init(
        observeCardState: ObserveCardStateUseCase,
        onActivate: @escaping () -> Void,
        onScratch: @escaping () -> Void
    ) {
        self.observeCardState = observeCardState
        self.onActivate = onActivate
        self.onScratch = onScratch
    }

    func observe() async {
        let stream = await observeCardState.run()
        for await state in stream {
            self.cardState = state
        }
    }

    func scratch() {
        onScratch()
    }

    func activateCard() {
        onActivate()
    }
}
