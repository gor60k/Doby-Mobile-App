import SwiftUI

struct User: Codable {
    let uuid: String
    var username: String
    var firstName: String?
    var lastName: String?
    var patronymic: String?
    var avatar: String?
    var phone: String?
    var city: City?
    var bio: String?
    var pets: [Pet]?
}
