import Foundation

struct UpdateUserRequest: Codable {
    let first_name: String?
    let last_name: String?
    let patronymic: String?
    let phone: String?
    let avatar: String?
    let city: CityDTO?
    let bio: String?
}
