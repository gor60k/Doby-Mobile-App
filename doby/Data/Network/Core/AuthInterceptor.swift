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
        Task {
            var urlRequest = urlRequest
            
            if let token = await keychain.getToken(for: .accessToken) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            completion(.success(urlRequest))
        }
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.response?.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
        
        Task {
            do {
                _ = try await tokenManager.refresh(session: self.session, keychain: keychain)
                completion(.retry)
            } catch {
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
