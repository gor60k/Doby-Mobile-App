import Foundation

struct PetPhotoRequestMapper {
    nonisolated static func map(from input: PetPhotoInput) -> PetPhotoRequest {
        return PetPhotoRequest(
            image: input.image,
            order_number: input.orderNumber,
            is_main: input.isMain
        )
    }
}
