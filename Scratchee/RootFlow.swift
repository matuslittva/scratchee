import SwiftUI

@MainActor
struct RootFlow: View {
    enum Destination: Hashable {
        case scratch
        case activate
    }

    @State private var path: [Destination] = []
    private let factory: AppFactory

    init(factory: AppFactory) {
        self.factory = factory
    }

    var body: some View {
        NavigationStack(path: $path) {
            factory.makeHomeView(
                onScratch: { path.append(.scratch) },
                onActivate: { path.append(.activate) }
            )
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .scratch:
                    factory.makeScratchView {
//                        path.removeLast()
                    }
                case .activate:
                    factory.makeActivationView {
                        path.removeLast()
                    }
                }
            }
        }
    }
}
