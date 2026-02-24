import Foundation

final class APIClient: APIClientProtocol {
    func request<T>(_ endpoint: any APIEndpointProtocol) async throws -> T where T : Decodable {
        
        // MARK: - базовый урл апишки
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        // MARK: - описание реквеста с заголовками
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // MARK: - дата и ответ от апишки
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("REQUEST URL:", url)
        print("STATUS CODE:", httpResponse.statusCode)

        if !(200..<300).contains(httpResponse.statusCode) {
            if let responseBody = String(data: data, encoding: .utf8) {
                print("RESPONSE BODY:", responseBody)
            }
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func voidRequest(_ endpoint: any APIEndpointProtocol) async throws {
        
        // MARK: - базовый урл апишки
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        // MARK: - описание реквеста с заголовками
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // MARK: - дата и ответ от апишки
        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("REQUEST URL:", url)
        print("STATUS CODE:", httpResponse.statusCode)

        if !(200..<300).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
    }
}
