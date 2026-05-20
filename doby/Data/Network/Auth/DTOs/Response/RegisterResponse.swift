import Foundation

nonisolated
struct RegisterResponse: Codable, Sendable {
    let user: UserDTO
    let access_token: String
    let refresh_token: String
}
