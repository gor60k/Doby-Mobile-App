struct PetGenderMapper {
    nonisolated static func mapToDomain(from dto: PetGenderDTO) -> PetGender {
        switch dto {
        case .male: return .male
        case .female: return .female
        }
    }
    
    nonisolated static func mapToDTO(from domain: PetGender) -> PetGenderDTO {
        switch domain {
        case .male: return .male
        case .female: return .female
        }
    }
    
    nonisolated static func mapToDTO(from domain: PetGender?) -> PetGenderDTO? {
        domain.map(mapToDTO(from:))
    }
}
