import Foundation
import Observation

@Observable
final class SessionService {
    static let shared = SessionService()
    
    private let userStorageKey: String = "currentUser"
    private let roleStorageKey: String = "selectedUserRole"
    private let authStorageKey: String = "isAuthenticated"
    private let regStorageKey: String = "isRegistered"
    
    private init() {}
    
    var currentUser: User? {
        get {
            if let data = UserDefaults.standard.data(forKey: userStorageKey),
               let user = try? JSONDecoder().decode(User.self, from: data) {
                return user
            }
            return nil
        }
        set {
            if let newValue = newValue,
               let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: userStorageKey)
            } else {
                UserDefaults.standard.removeObject(forKey: userStorageKey)
            }
        }
    }
    
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
