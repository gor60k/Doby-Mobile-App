import Alamofire

final class AuthSession {
    private let session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    func refresh(refresh: String) async throws -> RefreshResponse {
        print("📡 [AuthSession] Отправка сетевого запроса на /auth/refresh...")
        
        do {
            let response = try await session.request(
                "auth/refresh", // Убедись, что здесь полный URL или корректный BaseURL
                method: .post,
                parameters: ["refresh": refresh]
            )
            .validate()
            .serializingDecodable(RefreshResponse.self)
            .value
            
            print("✅ [AuthSession] Сервер успешно вернул новые токены")
            return response
        } catch {
            print("❌ [AuthSession] Сетевая ошибка при рефреше: \(error)")
            throw error
        }
    }
}
