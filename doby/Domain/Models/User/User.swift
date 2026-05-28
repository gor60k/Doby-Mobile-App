import SwiftUI

struct User: Codable {
    let uuid: String
    var username: String
    var firstName: String?
    var lastName: String?
    var patronymic: String?
    var avatar: String? //TODO: убрать поле аватар
    var phone: String?
    var city: City?
    var bio: String?
    var pets: [Pet]?
}
