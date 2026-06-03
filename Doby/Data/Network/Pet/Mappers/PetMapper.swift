import Foundation

struct PetMapper {
    nonisolated static func mapToRequest(from input: CreatePetInput) -> PetRequest {
        return PetRequest(
            pet_type: PetTypeMapper.mapToDTO(from: input.petType),
            uploaded_photos: input.uploadedPhotos,
            name: input.name,
            age: input.age,
            sex: PetGenderMapper.mapToDTO(from: input.gender),
            height: input.height,
            weight: input.weight,
            breed_name: input.breedName,
            diet_type: input.dietType,
            diet_pattern: input.dietPattern,
            additional_info: input.additionalInfo,
            diet_additional_info: input.dietAdditionalInfo,
            warning_tags: input.warningTags,
            specific_features: input.specificTags
        )
    }
    
    nonisolated static func mapToDomain(from response: PetDTO) -> Pet {
        return Pet(
            id: response.id,
            petType: PetTypeMapper.mapToDomain(from: response.pet_type),
            ownerUUID: response.owner_uuid,
            name: response.name,
            age: response.age,
            gender: PetGenderMapper.mapToDomain(from: response.sex),
            height: response.height ?? 0,
            weight: response.weight ?? 0,
            breedName: response.breed_name,
            dietType: response.diet_type,
            dietPatterns: response.diet_pattern,
            warningTags: response.warning_tags,
            specificTags: response.specific_features,
            additionalInfo: response.additional_info,
            dietAdditionalInfo: response.diet_additional_info,
            photos: PetPhotoMapper.mapToDomain(from: response.photos)
        )
    }
    
    nonisolated static func mapToDomain(from response: [PetDTO]) -> [Pet] {
        response.map(mapToDomain(from:))
    }
    
    nonisolated static func mapToDomain(from response: [PetDTO]?) -> [Pet]? {
        response.map(mapToDomain(from:))
    }
}
