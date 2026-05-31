struct UserMapper {
    nonisolated static func map(dto: UserDTO) -> User {
        User(
            uuid: dto.uuid,
            username: dto.username,
            firstName: dto.first_name,
            lastName: dto.last_name,
            patronymic: dto.patronymic,
            phone: dto.phone,
            city: dto.city.map(mapCity),
            bio: dto.bio
        )
    }
    
    nonisolated static func map(dtos: [UserDTO]) -> [User] {
        dtos.map(map)
    }
    
    nonisolated static func mapToRecord(dto: UserDTO) -> UserRecord {
        UserRecord(
            uuid: dto.uuid,
            username: dto.username,
            firstName: dto.first_name,
            lastName: dto.last_name,
            patronymic: dto.patronymic
        )
    }
    
    nonisolated static func mapToRecord(dtos: [UserDTO]) -> [UserRecord] {
        dtos.map(mapToRecord)
    }
    
    nonisolated private static func mapCity(_ dto: CityDTO) -> City {
        City(
            id: dto.id,
            name: dto.name,
            translit: dto.translit
        )
    }
}
