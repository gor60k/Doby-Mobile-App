import Foundation

struct AuthResponse: Decodable {
    let user: AuthUser
    let token: String
}

struct AuthUser: Decodable, Encodable {
    let id: String
    let name: String
    let email: String
    let role: Role?
}
