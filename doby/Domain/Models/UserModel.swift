import SwiftUI

enum Role: String, Codable {
    case owner = "OWNER"
    case sitter = "SITTER"
}

struct UserModel: Codable, Identifiable {
    var id = UUID()
    var name: String
    let role: Role
    var phone: String
    var icon: String?
}
