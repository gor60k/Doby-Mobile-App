import SwiftUI

enum Role: String, Codable {
    case owner = "OWNER"
    case sitter = "SITTER"
}

struct User: Codable, Identifiable {
    let id: Int
    let username: String
    let email: String
    let avatar: String?
    let phone: String
    let city: City?
    let bio: String?
    let sitter_profile: SitterProfile?
}
