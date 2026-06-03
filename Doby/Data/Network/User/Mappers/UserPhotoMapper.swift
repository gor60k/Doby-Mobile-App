struct UserPhotoMapper {
    // MARK: - Маппинг в модель запроса
    nonisolated static func mapToRequest(from input: UserPhotoInput) -> UserPhotoRequest {
        return UserPhotoRequest(
            image: input.image,
            order_number: input.orderNumber,
            is_main: input.isMain
        )
    }
    
    // MARK: - Маппинг в доменную модель
    nonisolated static func mapToDomain(from dto: UserPhotoDTO) -> UserPhoto {
        return UserPhoto(
            id: dto.id,
            imageURL: dto.image_url,
            orderNumber: dto.order_number,
            isMain: dto.is_main
        )
    }
    
    nonisolated static func mapToDomain(from dtos: [UserPhotoDTO]) -> [UserPhoto] {
        dtos.map(mapToDomain(from:))
    }
    
    nonisolated static func mapToDomain(from dtos: [UserPhotoDTO]?) -> [UserPhoto]? {
        dtos.map(mapToDomain(from:))
    }
}
