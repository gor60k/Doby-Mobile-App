import SwiftUI

struct RoleDisclosureItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let systemImage: String
    let role: Role?
}

