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
}
