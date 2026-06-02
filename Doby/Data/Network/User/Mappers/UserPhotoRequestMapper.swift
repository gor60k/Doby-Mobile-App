struct UserPhotoMapper {
    nonisolated static func mapToRequest(from input: UserPhotoInput) -> UserPhotoRequest {
        return UserPhotoRequest(
            image: input.image,
            order_number: input.orderNumber,
            is_main: input.isMain
        )
    }
    
    nonisolated static func mapToDomain(from dto: UserPhotoDTO) -> UserPhoto {
        return UserPhoto(
            id: dto.id,
            imageURL: dto.image_url,
            orderNumber: dto.order_number,
            isMain: dto.is_main
        )
    }
}
