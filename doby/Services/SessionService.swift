import Foundation
import Observation

@Observable
final class SessionService {
    static let shared = SessionService()
    private let authStorageKey: String = "isAuthenticated"
    private let regStorageKey: String = "isRegistered"
    
    private init() {}
    
    var isRegistered: Bool {
        get {
            return UserDefaults.standard.bool(forKey: regStorageKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: regStorageKey)
            print("REG STATUS UPDATED:", newValue)
        }
    }
    
    var isAuthenticated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: authStorageKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: authStorageKey)
            print("AUTH STATUS UPDATED:", newValue)
        }
    }
    
    func removeKey(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
