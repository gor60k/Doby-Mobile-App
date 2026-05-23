struct CityMapper {
    nonisolated static func map(dto: CityDTO) -> City {
        City(
            id: dto.id,
            name: dto.name,
            translit: dto.translit
        )
    }
    
    nonisolated static func map(dto: [CityDTO]) -> [City] {
        dto.map(map(dto:))
    }
}
