enum PetTypeDTO: String, CaseIterable, Codable {
    case dog, cat
}

extension PetTypeDTO {
    func toDomain() -> PetType {
        switch self {
        case .dog: return .dog
        case .cat: return .cat
        }
    }
}
