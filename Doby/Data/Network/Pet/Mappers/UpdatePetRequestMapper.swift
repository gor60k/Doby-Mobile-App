import Foundation

struct UpdatePetRequestMapper {
    nonisolated static func map(from input: UpdatePetInput) -> UpdatePetRequest {
        return UpdatePetRequest(
            pet_type: input.petType.map(mapType),
            name: input.name,
            age: input.age,
            sex: input.gender.map(mapGender),
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
    
    nonisolated private static func mapType(from type: PetType) -> PetTypeDTO {
        switch type {
        case .dog: return .dog
        case .cat: return .cat
        }
    }
    
    nonisolated private static func mapGender(from gender: Gender) -> GenderDTO {
        switch gender {
        case .male: return .male
        case .female: return .female
        }
    }
}


