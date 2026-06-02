import Foundation

struct PetPhotoMapper {
    nonisolated static func mapToRequest(from input: PetPhotoInput) -> PetPhotoRequest {
        return PetPhotoRequest(
            image: input.image,
            order_number: input.orderNumber,
            is_main: input.isMain
        )
    }
    
    nonisolated static func mapToDomain(from response: PetPhotoDTO) -> PetPhoto {
        return PetPhoto(
            id: response.id,
            imageURL: response.image_url,
            orderNumber: response.order_number,
            isMain: response.is_main
        )
    }
    
    nonisolated static func mapToDomain(from response: [PetPhotoDTO]) -> [PetPhoto] {
        response.map(mapToDomain(from:))
    }
}
