import Security
import Foundation


//TODO: - убрать shared и передавать экзепляр сервиса при сборке приложения
actor KeychainService: Sendable {
    enum TokenKey {
        case accessToken
        case refreshToken
    }
    
    static let shared = KeychainService()
    
    init() {}
    
    @discardableResult
    nonisolated func save(token: String, for key: TokenKey) -> Bool {
        let data = Data(token.utf8)
        // Сокращенный токен для логов: "eyJhbG...6eKY"
        let shortToken = "\(token.prefix(10))...\(token.suffix(4))"
        
        let baseQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Bundle.main.bundleIdentifier ?? "com.doby.app",
            kSecAttrAccount as String: "\(key)" // Используем строку для аккаунта
        ]
        
        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]
        
        let updateStatus = SecItemUpdate(baseQuery as CFDictionary, attributesToUpdate as CFDictionary)
        
        if updateStatus == errSecSuccess {
            print("💾 [Keychain] ОБНОВЛЕН токен для \(key): \(shortToken)")
            return true
        }
        
        if updateStatus == errSecItemNotFound {
            var addQuery = baseQuery
            addQuery[kSecValueData as String] = data
            addQuery[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            
            let addStatus = SecItemAdd(addQuery as CFDictionary, nil)
            if addStatus == errSecSuccess {
                print("💾 [Keychain] СОХРАНЕН новый токен для \(key): \(shortToken)")
            } else {
                print("❌ [Keychain] ОШИБКА сохранения для \(key): \(addStatus)")
            }
            return addStatus == errSecSuccess
        }
        
        return false
    }

    func getToken(for key: TokenKey) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Bundle.main.bundleIdentifier ?? "com.doby.app",
            kSecAttrAccount as String: "\(key)",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var data: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &data)
        
        guard status == errSecSuccess, let tokenData = data as? Data,
              let token = String(data: tokenData, encoding: .utf8) else {
            print("🔍 [Keychain] Токен для \(key) НЕ НАЙДЕН")
            return nil
        }
        
        let shortToken = "\(token.prefix(10))...\(token.suffix(4))"
        print("🔍 [Keychain] ИЗВЛЕЧЕН токен для \(key): \(shortToken)")
        return token
    }
    
    nonisolated func deleteToken(for key: TokenKey) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Bundle.main.bundleIdentifier ?? "com.doby.app",
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
