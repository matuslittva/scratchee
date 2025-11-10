import SwiftUI

@MainActor
struct ScratchView: View {
    @ObservedObject var viewModel: ScratchViewModel

    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                Text("Scratch the card")
                    .font(.largeTitle.weight(.semibold))
                    .padding(.top, 16)

                Text("Press the button below to reveal your code.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                if viewModel.isScratching {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.4)
                }

                Spacer()

                Button(action: viewModel.scratch) {
                    Text("Scratch")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .disabled(viewModel.isScratching)

                Spacer()
            }
        }
        .onDisappear {
            viewModel.cancel()
        }
        .animation(.easeInOut, value: viewModel.isScratching)
    }
}
