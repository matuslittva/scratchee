enum HTTPError: Error {
    case badStatus(Int)
    case decodingFailed
    case invalidURL
}
