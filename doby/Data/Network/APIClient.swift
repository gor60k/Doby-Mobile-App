import Foundation

final class APIClient: APIClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    func request<T>(_ endpoint: APIEndpointProtocol) async throws -> T where T: Decodable {
        let (data, _) = try await performRequest(for: endpoint)
        return try decoder.decode(T.self, from: data)
    }

    func voidRequest(_ endpoint: any APIEndpointProtocol) async throws {
        _ = try await performRequest(for: endpoint)
    }

    private func performRequest(for endpoint: APIEndpointProtocol) async throws -> (Data, HTTPURLResponse) {
        let request = makeRequest(from: endpoint)
        logRequest(request)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        logResponse(httpResponse, data: data)

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return (data, httpResponse)
    }

    private func makeRequest(from endpoint: APIEndpointProtocol) -> URLRequest {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    private func logRequest(_ request: URLRequest) {
        #if DEBUG
        print("REQUEST HEADERS:", request.allHTTPHeaderFields ?? [:])
        print("REQUEST URL:", request.url?.absoluteString ?? "nil")
        #endif
    }

    private func logResponse(_ response: HTTPURLResponse, data: Data) {
        #if DEBUG
        print("STATUS CODE:", response.statusCode)

        if !(200..<300).contains(response.statusCode),
           let responseBody = String(data: data, encoding: .utf8) {
            print("RESPONSE BODY:", responseBody)
        }
        #endif
    }
}
