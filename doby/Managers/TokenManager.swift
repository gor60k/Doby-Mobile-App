import Alamofire
import Foundation

actor TokenManager {
    private var refreshTask: Task<String, Error>?
//    nonisolated private let sessionService: SessionService = .shared
    private let sessionService: SessionService
    
    init(sessionService: SessionService) {
        self.sessionService = sessionService
    }
    
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
                await handleInvalidSession()
                throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 401))
            }
            
            do {
                let tokens = try await session.refresh(refresh: refreshToken)
                
                keychain.save(token: tokens.access, for: .accessToken)
                keychain.save(token: tokens.refresh, for: .refreshToken)
                
                return tokens.access
            } catch {
                if let afError = error.asAFError,
                   case let .responseValidationFailed(reason) = afError,
                   case let .unacceptableStatusCode(code) = reason,
                   code == 401 || code == 500 {
                    await handleInvalidSession()
                }
                
                throw error
            }
        }
        
        refreshTask = task
        return try await task.value
    }
    
    private func resetTask() {
        self.refreshTask = nil
    }
    
    private func handleInvalidSession() async {
        await MainActor.run { self.sessionService.invalidSession() }
    }
}
