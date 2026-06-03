import Foundation

nonisolated struct UserPhotoRequest: Codable {
    let image: Data
    let order_number: Int
    let is_main: Bool?
}
