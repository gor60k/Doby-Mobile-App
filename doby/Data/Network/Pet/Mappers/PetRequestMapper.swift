struct PetRequestMapper {
    
    static func map(input: CreatePetInput) -> PetRequest {
        return PetRequest(
            pet_type: mapType(input.petType),
            uploaded_photos: input.uploadedPhotos,
            name: input.name,
            age: input.age,
            sex: mapGenger(input.gender),
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
    
    private static func mapType(_ type: PetType) -> PetTypeDTO {
        switch type {
        case .dog: return .dog
        case .cat: return .cat
        }
    }
    
    private static func mapGenger(_ gender: Gender) -> GenderDTO {
        switch gender {
        case .male: return .male
        case .female: return .female
        }
    }
}
