import Foundation

nonisolated
struct PetPhotoRequest: Codable {
    let image: String
    let order_number: Int
    let is_main: Bool?
}
