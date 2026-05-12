import Foundation
import Observation

@MainActor
@Observable
final class SessionService {
    static let shared = SessionService()
    
    private var keychainService: KeychainService = .shared
    private var userStorage: UserStorage = .shared
    private var petStorage: PetStorage = .shared
    
    private let authStorageKey = "isAuthenticated"
    private let regStorageKey = "isRegistered"
    
    private(set) var isRegistered: Bool
    private(set) var isAuthenticated: Bool
    
    init() {
        self.isRegistered = UserDefaults.standard.bool(forKey: regStorageKey)
        self.isAuthenticated = UserDefaults.standard.bool(forKey: authStorageKey)
    }
    
    func setAuthenticated(_ value: Bool) {
        isAuthenticated = value
        UserDefaults.standard.set(value, forKey: authStorageKey)
    }
    
    func setRegistered(_ value: Bool) {
        isRegistered = value
        UserDefaults.standard.set(value, forKey: regStorageKey)
    }
    
    func logout() {
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: authStorageKey)
        
        userStorage.clear()
        petStorage.clear()
    }
    
    func invalidSession() {
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: authStorageKey)
        keychainService.deleteToken(for: .accessToken)
        keychainService.deleteToken(for: .refreshToken)
        
        userStorage.clear()
        petStorage.clear()
    }
}
