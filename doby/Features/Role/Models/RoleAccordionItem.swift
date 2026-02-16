import SwiftUI

struct RoleAccordionItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let systemImage: String
    let roleValue: String
    let bgColor: Color?
}

