@testable import Scratchee

final class VersionRepositorySpy: VersionRepository, @unchecked Sendable {
    private(set) var callCount = 0
    var result: () async throws -> Version

    init(result: @escaping () async throws -> Version) {
        self.result = result
    }

    func fetchVersion() async throws -> Version {
        callCount += 1
        return try await result()
    }
}
