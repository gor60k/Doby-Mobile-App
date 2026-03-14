import Foundation

struct AuthResponse: Decodable, Encodable {
    let user: AuthUser
    let access_token: String
    let refresh_token: String
}

struct AuthUser: Decodable, Encodable {
    let id: Int
    let username: String
    let email: String
    let avatar: String?
    let phone: String
    let city: City?
    let bio: String?
    let sitter_pofile: SitterProfile?
}

// MARK: - структуры полей юзера
struct SitterProfile: Decodable, Encodable {
    let experience_years: Int
    let price_per_hour: Int
    let is_verified: Bool
}

struct City: Decodable, Encodable, Equatable {
    let name: String
    let translit: String
}
