import Foundation

struct UpdateUserRequest: Codable {
    let first_name: String?
    let last_name: String?
    let phone: String?
    let city: Int?
    let bio: String?
}
