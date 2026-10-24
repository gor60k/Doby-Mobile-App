import Foundation

nonisolated struct PhotoRequest: Codable {
    let image: Data
    let order_number: Int
    let is_main: Bool
}
