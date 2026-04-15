import Foundation

final class APIClient: APIClientProtocol {
    private let session: URLSession
    private let decoder = JSONDecoder()

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<E: APIEndpointProtocol>(_ endpoint: E) async throws -> E.Response {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body

        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        if E.Response.self == EmptyResponse.self {
            return EmptyResponse() as! E.Response
        }

        return try decoder.decode(E.Response.self, from: data)
    }
}
