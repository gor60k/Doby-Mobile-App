import Foundation
import Observation

@Observable
final class SessionService {
    static let shared = SessionService()
    
    private let authStorageKey = "isAuthenticated"
    private let regStorageKey = "isRegistered"
    
    private(set) var isRegistered: Bool
    private(set) var isAuthenticated: Bool
    
    private init() {
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
    }
}
