import Foundation

protocol ScratchCardUseCase: Sendable {
    func run() async
}

struct ScratchCardUseCaseLive: ScratchCardUseCase {
    let cardsRepository: CardsRepository

    func run() async {
        await cardsRepository.setState(.scratching)
        do {
            let code = try await cardsRepository.scratch()
            try Task.checkCancellation()
            await cardsRepository.setState(.scratched(code: code))
        } catch is CancellationError {
            return
        } catch {
            await cardsRepository.setState(.error(message: "Scratch failed"))
        }
    }
}
