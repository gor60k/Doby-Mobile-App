struct PetTypeMapper {
    nonisolated static func mapToDomain(from dto: PetTypeDTO) -> PetType {
        switch dto {
        case .dog: return .dog
        case .cat: return .cat
        }
    }
    
    nonisolated static func mapToDTO(from domain: PetType) -> PetTypeDTO {
        switch domain {
        case .dog: return .dog
        case .cat: return .cat
        }
    }
    
    nonisolated static func mapToDTO(from domain: PetType?) -> PetTypeDTO? {
        domain.map(mapToDTO(from:))
    }
}
