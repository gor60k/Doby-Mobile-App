import Foundation

struct PetPhotoMapper {
    nonisolated static func mapToRequest(from input: PhotoInput) -> PhotoRequest {
        return PhotoRequest(
            image: input.image,
            order_number: input.orderNumber,
            is_main: input.isMain
        )
    }
    
    nonisolated static func mapToDomain(from response: PhotoDTO) -> Photo {
        return Photo(
            id: response.id,
            imageURL: response.image_url,
            orderNumber: response.order_number,
            isMain: response.is_main
        )
    }
    
    nonisolated static func mapToDomain(from response: [PhotoDTO]) -> [Photo] {
        response.map(mapToDomain(from:))
    }
}
