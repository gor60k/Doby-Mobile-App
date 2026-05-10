import Alamofire

final class AuthSession {
    private let session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    func refresh(refresh: String) async throws -> RefreshResponse {
        let baseUrl = APIConstants.baseURL
        
        do {
            let response = try await session.request(
                "\(baseUrl)/auth/token/refresh",
                method: .post,
                parameters: ["refresh": refresh],
                encoding: JSONEncoding.default
            )
            .validate()
            .serializingDecodable(RefreshResponse.self)
            .value
            
            return response
        } catch {
            throw error
        }
    }
}
