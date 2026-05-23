import Foundation

nonisolated
struct CityDTO: Codable, Equatable {
    var id: Int
    var name: String
    var translit: String
}
