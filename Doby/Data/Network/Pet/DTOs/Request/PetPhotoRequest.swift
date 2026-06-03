import Foundation

nonisolated
struct PetPhotoRequest: Codable {
    let image: Data
    let order_number: Int
    let is_main: Bool?
}
