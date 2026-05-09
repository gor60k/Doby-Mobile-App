import Alamofire
import Foundation

actor TokenManager {
    private var refreshTask: Task<String, Error>?
    
    func getValidToken(keychain: KeychainService) async -> String? {
        if let task = refreshTask {
            return try? await task.value
        }
        return await keychain.getToken(for: .accessToken)
    }
    
    func refreshToken(session: AuthSession, keychain: KeychainService) async throws -> String {
        if let task = refreshTask {
            return try await task.value
        }
        
        let task = Task<String, Error> {
            defer {
                self.resetTask()
            }
            
            guard let refreshToken = await keychain.getToken(for: .refreshToken) else {
                throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 401))
            }
            
            let tokens = try await session.refresh(refresh: refreshToken)
            
            keychain.save(token: tokens.access, for: .accessToken)
            keychain.save(token: tokens.refresh, for: .refreshToken)
            
            return tokens.access
        }
        
        refreshTask = task
        return try await task.value
    }
    
    private func resetTask() {
        self.refreshTask = nil
    }
}
