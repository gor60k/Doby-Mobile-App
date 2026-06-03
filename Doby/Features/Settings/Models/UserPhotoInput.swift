import Foundation

struct UserPhotoInput: Codable {
    let image: Data
    let orderNumber: Int
    let isMain: Bool
}
