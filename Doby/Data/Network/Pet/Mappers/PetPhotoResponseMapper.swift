import Foundation

struct PetPhotoResponseMapper {
    nonisolated static func map(from response: PetPhotoResponse) -> PetPhoto {
        return PetPhoto(
            id: response.id,
            imageURL: response.image_url,
            orderNumber: response.order_number,
            isMain: response.is_main
        )
    }
}
