import Foundation

struct LoginResponse: Codable {
    let user: UserDTO
    let access_token: String
    let refresh_token: String
}
