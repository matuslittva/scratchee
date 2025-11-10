@MainActor
final class AppFactory {
    let httpClient: HTTPClient
    let versionRepository: VersionRepository
    let cardsRepository: CardsRepository

    init() {
        self.httpClient = HTTPClientLive()
        self.versionRepository = VersionRepositoryLive(client: httpClient)
        self.cardsRepository = CardsRepositoryLive()
    }
}
