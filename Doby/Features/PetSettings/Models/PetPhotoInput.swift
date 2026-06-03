import Foundation

struct PetPhotoInput: Codable {
    let image: Data
    let orderNumber: Int
    let isMain: Bool?
}
