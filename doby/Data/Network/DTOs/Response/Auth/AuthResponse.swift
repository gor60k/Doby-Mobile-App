import Foundation

struct AuthResponse: Decodable, Encodable {
    let user: AuthUser
    let access_token: String
    let refresh_token: String
}

struct AuthUser: Decodable, Encodable {
    let uuid: UUID
    var username: String
    var first_name: String?
    var last_name: String?
    var patronymic: String?
    var avatar: String?
    var phone: String?
    var city: City?
    var bio: String?
    let sitter_profile: SitterProfile?
}



