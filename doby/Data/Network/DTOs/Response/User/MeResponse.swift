import Foundation

struct MeResponse: Decodable, Encodable {
    let uuid: UUID
    var username: String
    var first_name: String?
    var last_name: String?
    var patronymic: String?
    var avatar: String?
    var phone: String?
    var city: CityDTO?
    var bio: String?
}

extension MeResponse: UserProtocol {
    var sitter_profile: SitterProfileDTO? { nil }
}
