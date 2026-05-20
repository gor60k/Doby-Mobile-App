import Foundation

nonisolated
struct MeResponse: Codable, Sendable {
    let uuid: String
    var username: String
    var first_name: String?
    var last_name: String?
    var patronymic: String?
    var avatar: String?
    var phone: String?
    var city: CityDTO?
    var bio: String?
}
