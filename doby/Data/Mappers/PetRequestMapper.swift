struct PetRequestMapper {
    
    static func map(input: CreatePetInput) -> PetRequest {
        return PetRequest(
            pet_type: mapType(input.petType),
            name: input.name,
            age: input.age,
            warning_tags: input.warningTags,
            specific_tags: input.specificTags
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
