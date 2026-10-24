struct CityMapper {
    // MARK: - Маппинг в доменную модель

    nonisolated static func mapToDomain(from dto: CityDTO) -> City {
        City(
            id: dto.id,
            name: dto.name,
            translit: dto.translit
        )
    }

    nonisolated static func mapToDomain(from dto: CityDTO?) -> City? {
        dto.map(mapToDomain(from:))
    }

    nonisolated static func mapToDomain(from dtos: [CityDTO]) -> [City] {
        dtos.map(mapToDomain(from:))
    }

    // MARK: - Маппинг в модель для БД

    nonisolated static func mapToRecord(from dto: CityDTO) -> CityRecord {
        CityRecord(
            id: dto.id,
            name: dto.name,
            translit: dto.translit
        )
    }

    nonisolated static func mapToRecord(from dto: CityDTO?) -> CityRecord? {
        dto.map(mapToRecord(from:))
    }

    nonisolated static func mapToRecord(from dtos: [CityDTO]) -> [CityRecord] {
        dtos.map(mapToRecord(from:))
    }
}
