import Foundation

struct UserPhoto: Codable, Hashable {
    let id: Int
    let imageURL: String
    let orderNumber: Int
    let isMain: Bool
}
