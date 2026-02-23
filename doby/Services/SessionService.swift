import Foundation
import Observation

@Observable
final class SessionService {
    
    var selectedRole: Role? {
        get {
            if let data = UserDefaults.standard.data(forKey: "selectedUserRole"),
               let role = try? JSONDecoder().decode(Role.self, from: data) {
                print("DATA IN USER DEFAULTS", role)
                return role
            }
            return nil
        }
        set {
            if let newValue = newValue,
               let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "selectedUserRole")
                print("DATA REWRITE USER DEFAULTS", data)
            } else {
                UserDefaults.standard.removeObject(forKey: "selectedUserRole")
            }
        }
    }
}
