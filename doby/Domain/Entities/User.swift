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
    let sitterProfile: SitterProfile?
}

extension User {
    init(dto: some UserProtocol) {
        self.uuid = dto.uuid
        self.username = dto.username
        self.firstName = dto.first_name
        self.lastName = dto.last_name
        self.patronymic = dto.patronymic
        self.avatar = dto.avatar
        self.phone = dto.phone
        self.city = dto.city?.toDomain()
        self.bio = dto.bio
        self.sitterProfile = dto.sitter_profile?.toDomain()
    }
}
