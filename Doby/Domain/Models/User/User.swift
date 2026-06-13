import Foundation

struct User: Codable {
    let uuid: String
    var username: String
    var firstName: String?
    var lastName: String?
    var patronymic: String?
    var phone: String?
    var city: City?
    var bio: String?
    var pets: [Pet]?
    var photos: [Photo]?
}
