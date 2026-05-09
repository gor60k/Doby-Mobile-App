import Foundation

struct CityDTO: Codable, Equatable, Sendable {
    var name: String
    var translit: String
}

//TODO: - убрать нахуй это расширение
extension CityDTO {
    func toDomain() -> City {
        return City(
            name: name, translit: translit
        )
    }
}
