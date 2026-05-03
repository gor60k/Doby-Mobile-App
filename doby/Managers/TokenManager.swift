import Alamofire
import Foundation

actor TokenManager {
    private var refreshTask: Task<String, Error>?
    
    func refresh(session: AuthSession, keychain: KeychainService) async throws -> String {
        if let existing = refreshTask {
            return try await existing.value
        }
        
        let task = Task<String, Error> {
            defer {
                self.resetTask()
            }
            
            guard let refreshToken = await keychain.getToken(for: .refreshToken) else {
                throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 401))
            }
            
            let tokens = try await session.refresh(refresh: refreshToken)
            
            await keychain.save(token: tokens.access, for: .accessToken)
            await keychain.save(token: tokens.refresh, for: .refreshToken)
            
            return tokens.access
        }

        self.refreshTask = task
        return try await task.value
    }
    
    private func resetTask() {
        self.refreshTask = nil
    }
}
