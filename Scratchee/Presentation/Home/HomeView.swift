import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                VStack(spacing: 4) {
                    Text("Scratch Card")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Check, scratch and activate your card")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                stateCard

                Spacer().frame(height: 20)

                VStack(spacing: 16) {
                    Button(action: viewModel.scratch) {
                        Text("Scratch")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.headline)
                    }

                    Button(action: viewModel.activateCard) {
                        Text("Activate")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.canActivate ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.headline)
                    }
                    .disabled(!viewModel.canActivate)
                }

                Spacer().frame(height: 40)
            }
            .padding(.top, 32)
        }
        .padding()
        .task {
            await viewModel.observe()
        }
    }

    private var stateCard: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .aspectRatio(1, contentMode: .fit)

            CardStateView(state: viewModel.cardState)
                .padding(32)
        }
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        .animation(.easeInOut(duration: 0.25), value: viewModel.cardState)
        .padding(.horizontal, 16)
    }
}
