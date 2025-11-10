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
            Text("")
        }
    }
}
