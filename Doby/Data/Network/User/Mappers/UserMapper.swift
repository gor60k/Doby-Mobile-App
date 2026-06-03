struct UserMapper {
    // MARK: - Маппинг в доменную модель
    nonisolated static func mapToDomain(from dto: UserDTO) -> User {
        User(
            uuid: dto.uuid,
            username: dto.username,
            firstName: dto.first_name,
            lastName: dto.last_name,
            patronymic: dto.patronymic,
            phone: dto.phone,
            city: CityMapper.mapToDomain(from: dto.city),
            bio: dto.bio,
            pets: PetMapper.mapToDomain(from: dto.pets),
            photos: UserPhotoMapper.mapToDomain(from: dto.photos)
        )
    }
    
    nonisolated static func mapToDomain(from dtos: [UserDTO]) -> [User] {
        dtos.map(mapToDomain(from:))
    }
    
    // MARK: - Маппинг в модель для SQLite
    nonisolated static func mapToRecord(from dto: UserDTO) -> UserRecord {
        UserRecord(
            uuid: dto.uuid,
            username: dto.username,
            firstName: dto.first_name,
            lastName: dto.last_name,
            patronymic: dto.patronymic
        )
    }
    
    nonisolated static func mapToRecord(from dtos: [UserDTO]) -> [UserRecord] {
        dtos.map(mapToRecord(from:))
    }
}
