struct VersionRepositoryLive: VersionRepository {
    let client: HTTPClient

    func fetchVersion() async throws -> Version {
        let dto: VersionResponse = try await client.get("https://api.o2.sk/version")
        return Version(dto.ios)
    }
}
