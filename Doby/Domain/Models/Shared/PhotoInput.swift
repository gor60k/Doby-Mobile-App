import Foundation

struct PhotoInput: Codable {
    let image: Data
    let orderNumber: Int
    let isMain: Bool
}
