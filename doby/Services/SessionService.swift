import Foundation
import Observation

@Observable
final class SessionService {
    private let roleStorageKey: String = "selectedUserRole"
    private let authStorageKey: String = "isAuthenticated"
    
    var selectedRole: Role? {
        get {
            if let data = UserDefaults.standard.data(forKey: roleStorageKey),
               let role = try? JSONDecoder().decode(Role.self, from: data) {
                print("DATA IN USER DEFAULTS", role)
                return role
            }
            return nil
        }
        set {
            if let newValue = newValue,
               let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: roleStorageKey)
                print("DATA REWRITE USER DEFAULTS", data)
            } else {
                UserDefaults.standard.removeObject(forKey: roleStorageKey)
            }
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
}
