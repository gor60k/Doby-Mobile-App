import Alamofire

final class AuthSession {
    private let session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    func refresh(refresh: String) async throws -> RefreshResponse {
        try await session.request(
            "auth/refresh",
            method: .post,
            parameters: ["refresh": refresh]
        )
        .validate()
        .serializingDecodable(RefreshResponse.self)
        .value
    }
}
