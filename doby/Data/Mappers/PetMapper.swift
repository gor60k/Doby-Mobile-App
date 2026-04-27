import Foundation

struct PetMapper {

    static func map(response: PetResponse) -> Pet {
        return Pet(
            id: response.id,
            petType: mapPetType(response.pet_type),
            ownerUUID: response.owner_uuid,
            name: response.name,
            age: response.age,
            height: response.height,
            weight: response.weight,
            breedName: response.breed_name,
            dietType: response.diet_type,
            dietPatterns: response.diet_patterns,
            warningTags: response.warning_tags,
            specificTags: response.specific_tags,
            dietAdditionalInfo: response.diet_additional_info,
            photos: mapPhotos(response.photos)
        )
    }

    private static func mapPetType(_ dto: PetTypeDTO) -> PetType {
        switch dto {
        case .dog: return .dog
        case .cat: return .cat
        }
    }

    private static func mapPhotos(_ dtos: [PetPhotoDTO]) -> [PetPhoto] {
        return dtos.map { dto in
            PetPhoto(
                id: dto.id,
                imageURL: dto.image_url,
                orderNumber: dto.order_number,
                isMain: dto.is_main
            )
        }
    }
}
