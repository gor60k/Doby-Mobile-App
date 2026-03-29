import Foundation
import Observation
import AuthenticationServices

@Observable
final class AuthViewModel {
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
    private var authService: AuthServiceProtocol
    
    private let refreshToken = "refreshToken"
    private let accessToken = "accessToken"
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var phone: String = ""
    var city: City? = nil
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    @MainActor
    func register() async {
        isLoading = true
        errorMessage = nil
        
        print("REGISTER START")
        
        do {
            let user = RegisterRequest(
                username: name,
                email: email,
                password: password,
                phone: phone,
                city_translit: city?.translit
            )
            
            let response = try await authService.register(user: user)
            
            session.currentUser = response.user
            
            session.isRegistered = true
            session.isAuthenticated = true
            print("USER SAVED: \(response.user)")
            
            keychain.save(token: response.refresh_token, for: refreshToken)
            keychain.save(token: response.access_token, for: accessToken)
            
            print("TOKENS SAVED: | ACCESS:\(response.access_token) | REFRESH:\(response.refresh_token)")
            
            print("REGISTER SUCCESS")
        } catch {
            errorMessage = error.localizedDescription
            print("REGISTER ERR: \(error)")
        }
        
        isLoading = false
    }
    
    func login() async {}
    
    func handleAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
        
    }
    
    @MainActor
    func handleAppleCompletion(_ result: Result<ASAuthorization, Error>) async {
        errorMessage = nil
        
        switch result {
        case .success(let authorization):
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                errorMessage = "Не удалось получить Apple ID"
                return
            }
            
            guard let identityToken = credential.identityToken,
                  let tokenString = String(data: identityToken, encoding: .utf8) else {
                errorMessage = "Не удалось получить токен идентификации"
                return
            }
            
            print("APPLE SIGN IN TOKEN: \(tokenString)")
            print("APPLE USER ID: \(credential.user)")
            
            if let email = credential.email {
                self.email = email
            }
            
            if let fullName = credential.fullName {
                let formatter = PersonNameComponentsFormatter()
                let formattedName = formatter.string(from: fullName)
                
                if !formattedName.isEmpty {
                    self.name = formattedName
                }
            }
            
            errorMessage = "Добавить обмен identityToken с бэком"
            
        case .failure(let error):
            errorMessage = error.localizedDescription
            print("APPLE SIGN IN ERR: \(error)")
        }
    }
    
    func logout() async {}
    
    func delete() async {}
}
