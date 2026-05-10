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

        let authEndpoints = ["/auth/login", "/auth/register", "/auth/token/refresh"]
        if authEndpoints.contains(where: { urlString.contains($0) }) {
            completion(.success(urlRequest))
            return
        }

        Task {
            if let token = await tokenManager.getValidToken(keychain: keychain) {
                var request = urlRequest
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                let shortToken = "\(token.prefix(10))...\(token.suffix(4))"
                
                completion(.success(request))
            } else {
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

        if let urlString = request.request?.url?.absoluteString, urlString.contains("/auth/logout") {
            completion(.doNotRetry)
            return
        }

        Task {
            do {
                _ = try await tokenManager.refreshToken(session: self.session, keychain: keychain)
                completion(.retry)
            } catch {
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
