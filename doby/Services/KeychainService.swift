import Security
import Foundation

actor KeychainService: Sendable {
    enum TokenKey {
        case accessToken
        case refreshToken
    }
    
    static let shared = KeychainService()
    
    private init() {}
    
    @discardableResult
    func save(token: String, for key: TokenKey) -> Bool {
        let data = Data(token.utf8)
        
        let baseQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Bundle.main.bundleIdentifier ?? "com.doby.app",
            kSecAttrAccount as String: key
        ]
        
        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]
        
        let updateStatus = SecItemUpdate(baseQuery as CFDictionary, attributesToUpdate as CFDictionary)
        
        if updateStatus == errSecSuccess {
            return true
        }
        
        if updateStatus != errSecItemNotFound {
            return false
        }
        
        var addQuery = baseQuery
        addQuery[kSecValueData as String] = data
        addQuery[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        
        let addStatus = SecItemAdd(addQuery as CFDictionary, nil)
        return addStatus == errSecSuccess
    }
    
    func getToken(for key: TokenKey) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Bundle.main.bundleIdentifier ?? "com.doby.app",
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var data: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &data)
        
        guard status == errSecSuccess else { return nil }
                
        guard let tokenData = data as? Data else { return nil }
        return String(data: tokenData, encoding: .utf8)
    }
    
    func authorizationHeaders(for key: TokenKey = .accessToken) -> [String: String] {
        guard let token = getToken(for: key), !token.isEmpty else {
            return [:]
        }
        
        return ["Authorization": "Bearer \(token)"]
    }
    
    func deleteToken(for key: TokenKey) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Bundle.main.bundleIdentifier ?? "com.doby.app",
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
