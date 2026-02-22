import SwiftUI

enum Role: String, Codable {
    case owner = "OWNER"
    case sitter = "SITTER"
}

struct User: Codable, Identifiable {
    var id = UUID()
    var name: String
    let role: Role
    var phone: String
    var icon: String?
}
