import Foundation
@testable import Scratchee

struct HTTPClientStub: HTTPClient {
    var result: () async throws -> Any

    func get<T: Decodable>(_ url: String) async throws -> T {
        let value = try await result()
        guard let cast = value as? T else {
            throw URLError(.badServerResponse)
        }
        return cast
    }
}
