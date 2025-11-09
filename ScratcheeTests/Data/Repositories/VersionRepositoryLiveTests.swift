import XCTest
@testable import Scratchee

final class VersionRepositoryLiveTests: XCTestCase {
    func test_givenValidResponse_whenFetchVersion_thenReturnsDomainVersion() async throws {
        let response = VersionResponse(ios: "6.24")
        let client = HTTPClientStub {
            response
        }
        let sut = makeSUT(client: client)

        let version = try await sut.fetchVersion()

        XCTAssertEqual(version, Version("6.24"))
    }

    func test_givenClientThrows_whenFetchVersion_thenErrorPropagates() async {
        let client = HTTPClientStub {
            throw URLError(.badServerResponse)
        }
        let sut = makeSUT(client: client)

        do {
            let _ = try await sut.fetchVersion()
            XCTFail("Expected error")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }

    private func makeSUT(client: HTTPClient) -> VersionRepositoryLive {
        VersionRepositoryLive(client: client)
    }
}
