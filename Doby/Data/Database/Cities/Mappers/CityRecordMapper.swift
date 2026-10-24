import Foundation

struct CityRecordMapper {
    nonisolated static func mapToRecord(from city: City) -> CityRecord {
        return CityRecord(
            id: city.id,
            name: city.name,
            translit: city.translit
        )
    }
    
    nonisolated static func mapToDomain(from record: CityRecord) -> City {
        return City(
            id: record.id,
            name: record.name,
            translit: record.translit
        )
    }
}
