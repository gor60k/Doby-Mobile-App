import Foundation

final class APIClient: APIClientProtocol {
    private let session: URLSession
    private let decoder = JSONDecoder()
    private let defaultHeaders: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<E: APIEndpointProtocol>(_ endpoint: E) async throws -> E.Response {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body

        let headers = defaultHeaders.merging(endpoint.headers ?? [:]) { _, new in new }
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                let responseBody = data.isEmpty ? nil : String(data: data, encoding: .utf8)
                throw APIError.httpError(
                    statusCode: httpResponse.statusCode,
                    url: url.absoluteString,
                    method: endpoint.method.rawValue,
                    body: responseBody
                )
            }

            if E.Response.self == EmptyResponse.self {
                return EmptyResponse() as! E.Response
            }

            do {
                return try decoder.decode(E.Response.self, from: data)
            } catch {
                throw APIError.decodingError(
                    error,
                    url: url.absoluteString,
                    method: endpoint.method.rawValue,
                    responseBody: String(data: data, encoding: .utf8)
                )
            }
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(
                error,
                url: url.absoluteString,
                method: endpoint.method.rawValue
            )
        }
    }
}
