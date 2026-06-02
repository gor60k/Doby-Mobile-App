import Foundation

struct City: Codable, Equatable, Hashable, Identifiable {
    var id: Int
    var name: String
    var translit: String
}
