import Combine
import SwiftUI

@main
struct ScratcheeApp: App {
    @StateObject private var factoryHolder = FactoryHolder()

    var body: some Scene {
        WindowGroup {
            RootFlow(factory: factoryHolder.factory)
        }
    }
}

@MainActor
final class FactoryHolder: ObservableObject {
    let factory = AppFactory()
}
