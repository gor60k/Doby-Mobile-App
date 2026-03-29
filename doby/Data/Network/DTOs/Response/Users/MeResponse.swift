import Foundation

struct MeResponse: Decodable, Encodable {
    let id: Int
    let username: String
    let email: String
    let avatar: String?
    let phone: String
    let city: City?
    let bio: String?
    let sitter_pofile: SitterProfile?
}

extension MeResponse {
    func toUser() -> User {
        User(
            id: id,
            username: username,
            email: email,
            avatar: avatar,
            phone: phone,
            city: city,
            bio: bio,
            sitter_profile: sitter_pofile
        )
    }
}

