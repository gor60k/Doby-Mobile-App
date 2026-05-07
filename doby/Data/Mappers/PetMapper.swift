import Foundation

struct PetMapper {

    nonisolated static func map(response: PetResponse) -> Pet {
        return Pet(
            id: response.id,
            petType: mapPetType(response.pet_type),
            ownerUUID: response.owner_uuid,
            name: response.name,
            age: response.age,
            height: response.height ?? 0,
            weight: response.weight ?? 0,
            breedName: response.breed_name,
            dietType: response.diet_type,
            dietPatterns: response.diet_pattern,
            warningTags: response.warning_tags,
            specificTags: response.specific_features,
            dietAdditionalInfo: response.diet_additional_info,
            photos: mapPhotos(response.photos)
        )
    }
    
    nonisolated static func map(response: [PetResponse]) -> [Pet] {
        response.map(map)
    }

    nonisolated private static func mapPetType(_ dto: PetTypeDTO) -> PetType {
        switch dto {
        case .dog: return .dog
        case .cat: return .cat
        }
    }

    nonisolated private static func mapPhotos(_ dtos: [PetPhotoDTO]) -> [PetPhoto] {
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
