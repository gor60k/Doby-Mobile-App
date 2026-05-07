import Alamofire
import Foundation


final class AuthInterceptor: RequestInterceptor {
    private let session: AuthSession
    private let tokenManager: TokenManager
    private let keychain = KeychainService.shared
    
    init(session: AuthSession, tokenManager: TokenManager) {
        self.session = session
        self.tokenManager = tokenManager
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let urlString = urlRequest.url?.absoluteString else {
            completion(.success(urlRequest))
            return
        }

        // 1. Исключаем эндпоинты авторизации
        let authEndpoints = ["/auth/login", "/auth/register", "/auth/refresh"]
        if authEndpoints.contains(where: { urlString.contains($0) }) {
            completion(.success(urlRequest))
            return
        }

        Task {
            if let token = await tokenManager.getValidToken(keychain: keychain) {
                var request = urlRequest
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                let shortToken = "\(token.prefix(10))...\(token.suffix(4))"
                print("🛠 [Adapt] В заголовок \(urlRequest.url?.lastPathComponent ?? "") добавлен: \(shortToken)")
                
                completion(.success(request))
            } else {
                print("ℹ️ [Adapt] Запрос уходит без токена (не найден в Keychain)")
                completion(.success(urlRequest))
            }
        }
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401,
              request.retryCount < 2 else {
            completion(.doNotRetry)
            return
        }

        // Если 401 пришел на запрос логаута — игнорируем рефреш
        if let urlString = request.request?.url?.absoluteString, urlString.contains("/auth/logout") {
            print("🚪 [Retry] 401 на логауте. Рефреш не нужен.")
            completion(.doNotRetry)
            return
        }

        Task {
            do {
                print("🔄 [Retry] Запуск обновления токена...")
                _ = try await tokenManager.refreshToken(session: self.session, keychain: keychain)
                completion(.retry)
            } catch {
                print("❌ [Retry] Рефреш не удался: \(error)")
                // Если рефреш сам вернул 401 — пора на экран логина
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
