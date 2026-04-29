import Foundation

struct UserDTO: Codable {
//    let uuid: UUID
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

//@propertyWrapper struct Lowercased: Codable, Equatable, Hashable {
//    var wrappedValue: UUID
//    
//    init(wrappedValue: UUID) {
//        self.wrappedValue = wrappedValue
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        wrappedValue = try container.decode(UUID.self)
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encode(wrappedValue.uuidString.lowercased())
//    }
//}
