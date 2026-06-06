import Foundation

struct Photo: Codable, Hashable, Identifiable {
    let id: Int
    let imageURL: String
    let orderNumber: Int
    let isMain: Bool
}
