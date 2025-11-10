import Foundation

protocol ActivateCardUseCase: Sendable {
    func run() async
}

struct ActivateCardUseCaseLive: ActivateCardUseCase, Sendable {
    let versionRepository: VersionRepository
    let cardsRepository: CardsRepository

    func run() async {
        do {
            let version = try await versionRepository.fetchVersion()

            let threshold = Version("6.1")

            if version > threshold {
                await cardsRepository.setState(.activated)
            } else {
                await cardsRepository.setState(.error(message: "Activation failed"))
            }

        } catch {
            await cardsRepository.setState(.error(message: "Network error"))
        }
    }
}
