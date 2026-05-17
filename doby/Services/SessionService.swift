import Foundation
import Observation

@MainActor
@Observable
final class SessionService {
    private let authStorageKey = "isAuthenticated"
    private let regStorageKey = "isRegistered"
    
//    private(set) var isRegistered: Bool
//    private(set) var isAuthenticated: Bool
    
    var isRegistered: Bool {
        didSet { persist() }
    }
    
    var isAuthenticated: Bool {
        didSet { persist() }
    }
    
    init() {
        self.isRegistered = UserDefaults.standard.bool(forKey: regStorageKey)
        self.isAuthenticated = UserDefaults.standard.bool(forKey: authStorageKey)
    }
    
    func setAuthenticated(_ value: Bool) {
        isAuthenticated = value
        persist()
    }
    
    func setRegistered(_ value: Bool) {
        isRegistered = value
        persist()
    }
    
    private func persist() {
        UserDefaults.standard.set(isRegistered, forKey: regStorageKey)
        UserDefaults.standard.set(isAuthenticated, forKey: authStorageKey)
    }
}
