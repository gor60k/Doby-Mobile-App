import SwiftUI

struct User: Codable {
    let uuid: UUID
    let username: String
    let firstName: String?
    let lastName: String?
    let patronymic: String?
    let avatar: String?
    let phone: String?
    let city: City?
    let bio: String?
}
