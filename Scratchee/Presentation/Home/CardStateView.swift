import SwiftUI

struct CardStateView: View {
    let state: CardState

    var body: some View {
        VStack(spacing: 16) {
            switch state {
            case .unscratched:
                Image(systemName: "square.dashed")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)

                Text("Card not scratched")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)

            case .scratched(let code):
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.green)

                Text("Scratched")
                    .font(.title3)
                    .fontWeight(.semibold)

                Text("Code: \(code.uuidString.prefix(8))…")
                    .font(.footnote)
                    .foregroundColor(.secondary)

            case .activated:
                Image(systemName: "bolt.shield.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)

                Text("Activated")
                    .font(.title3)
                    .fontWeight(.semibold)

            case .error(let message):
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.red)

                Text("Error")
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(message)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}
