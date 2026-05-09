import Foundation
import Alamofire

final class APIClient: APIClientProtocol {
    private let session: Session
    private let decoder: JSONDecoder
    
    init(session: Session) {
        self.session = session
        self.decoder = JSONDecoder()
    }
    
    func request<E: APIEndpointProtocol>(_ endpoint: E) async throws -> E.Response {
        if endpoint.isMultipart {
            return try await session.upload(
                multipartFormData: { formData in
                    endpoint.encodeMultipart(to: formData)
                },
                with: endpoint
            )
            .validate()
            .serializingDecodable(E.Response.self, decoder: decoder)
            .value
        } else {
            return try await session.request(endpoint)
                .validate()
                .serializingDecodable(E.Response.self, decoder: decoder)
                .value
        }
    }
}
