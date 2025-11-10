import SwiftUI

struct ActivationView: View {
    @StateObject var viewModel: ActivationViewModel

    var body: some View {
        VStack(spacing: 32) {

            Text("Activate Scratch Card")
                .font(.title3)
                .fontWeight(.semibold)

            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.4)
            }

            Button(
                action: {
                    Task { await viewModel.activate() }
                }
            ) {
                Text(viewModel.isLoading ? "Activating…" : "Activate")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isLoading ? Color.gray.opacity(0.4) : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(viewModel.isLoading)
            .animation(.easeInOut(duration: 0.2), value: viewModel.isLoading)

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 40)
        .navigationTitle("Activation")
    }
}
