import Foundation

struct CityDTO: Decodable, Encodable, Equatable {
    var name: String
    var translit: String
}

extension CityDTO {
    func toDomain() -> City {
        return City(
            name: name, translit: translit
        )
    }
}
