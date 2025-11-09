import Foundation

enum CardState: Equatable, Sendable {
    case unscratched
    case scratching
    case scratched(code: UUID)
    case activated
    case error(message: String)

    nonisolated static func == (lhs: CardState, rhs: CardState) -> Bool {
        switch (lhs, rhs) {
        case (.unscratched, .unscratched),
            (.scratching, .scratching),
            (.activated, .activated):
            return true

        case let (.scratched(a), .scratched(b)):
            return a == b

        case let (.error(a), .error(b)):
            return a == b

        default:
            return false
        }
    }
}
