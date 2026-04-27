import Foundation

struct RegisterResponse: Codable {
    let user: UserDTO
    let access_token: String
    let refresh_token: String
}
