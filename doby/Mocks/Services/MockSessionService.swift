final class MockSessionService {
    private let authStorageKey = "isAuthenticated"
    private let regStorageKey = "isRegistered"
    
    private(set) var isRegistered: Bool = true
    private(set) var isAuthenticated: Bool = false
}
