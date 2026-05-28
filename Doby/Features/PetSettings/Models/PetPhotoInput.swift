import Foundation

struct PetPhotoInput: Codable {
    let image: String
    let orderNumber: Int
    let isMain: Bool?
}
