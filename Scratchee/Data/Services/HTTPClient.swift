import Foundation

protocol HTTPClient {
    func get<T: Decodable>(_ url: String) async throws -> T
}

struct HTTPClientLive: HTTPClient {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    func get<T: Decodable>(_ url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw HTTPError.invalidURL
        }
        let (data, response) = try await session.data(from: url)

        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(http.statusCode) else {
            throw HTTPError.badStatus(http.statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw HTTPError.decodingFailed
        }
    }
}
