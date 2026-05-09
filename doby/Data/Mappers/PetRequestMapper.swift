struct PetRequestMapper {
    
    static func map(input: CreatePetInput) -> PetRequest {
        return PetRequest(
            pet_type: mapType(input.petType),
            uploaded_photos: input.uploadedPhotos,
            name: input.name,
            age: input.age,
            height: input.height,
            weight: input.weight,
            breed_name: input.breedName,
            diet_type: input.dietType,
            diet_pattern: input.dietPattern,
            diet_additional_info: input.dietAdditionalInfo,
            warning_tags: input.warningTags,
            specific_features: input.specificTags
        )
    }
    
    private static func mapType(_ type: PetType) -> PetTypeDTO {
        switch type {
        case .dog:
            return .dog
        case .cat:
            return .cat
        }
    }
    
}
