protocol VersionRepository: Sendable {
    func fetchVersion() async throws -> Version
}
