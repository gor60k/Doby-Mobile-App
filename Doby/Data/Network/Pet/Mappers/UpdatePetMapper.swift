import Foundation

struct UpdatePetMapper {
    nonisolated static func mapToRequest(from input: UpdatePetInput) -> UpdatePetRequest {
        return UpdatePetRequest(
            pet_type: PetTypeMapper.mapToDTO(from: input.petType),
            name: input.name,
            age: input.age,
            sex: PetGenderMapper.mapToDTO(from: input.gender),
            height: input.height,
            uploded_photos: input.uploadedPhotos,
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
}


