import Foundation

struct UserPhoto: Codable {
    let id: Int
    let imageURL: String
    let orderNumber: Int
    let isMain: Bool
}
