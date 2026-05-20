import Alamofire
import Foundation

actor TokenManager {
    private var refreshTask: Task<String, Error>?
    
    private let authAPI: AuthAPIProtocol
    private let keychainService: KeychainService
    private let sessionService: SessionService
    
    init(
        authAPI: AuthAPIProtocol,
        keychainService: KeychainService,
        sessionService: SessionService
    ) {
        self.authAPI = authAPI
        self.keychainService = keychainService
        self.sessionService = sessionService
    }
    
    func getValidToken() async -> String? {
        if let task = refreshTask {
            return try? await task.value
        }
        return await keychainService.getToken(for: .accessToken)
    }
    
    func refreshToken() async throws -> String {
        if let task = refreshTask {
            return try await task.value
        }
        
        let task = Task<String, Error> {
            defer {
                Task { await self.resetTask() }
            }
            
            guard let refreshToken = await keychainService.getToken(for: .refreshToken) else {
                await sessionService.setAuthenticated(false)
                throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 401))
            }
            
            do {
                let request = RefreshRequest(refresh: refreshToken)
                let response = try await authAPI.refresh(request)
                
                keychainService.save(token: response.access, for: .accessToken)
                keychainService.save(token: response.refresh, for: .refreshToken)
                
                return response.access
            } catch {
                if shouldInvalidateSession(error) {
                    await sessionService.setAuthenticated(false)
                }
                throw error
            }
        }
        
        refreshTask = task
        return try await task.value
    }
    
    private func resetTask() async {
        self.refreshTask = nil
    }
    
    private func shouldInvalidateSession(_ error: Error) -> Bool {
        guard let afError = error.asAFError,
              case let .responseValidationFailed(reason) = afError,
              case let .unacceptableStatusCode(code) = reason else {
            return false
        }
        
        return code == 401 || code == 500
    }
}
