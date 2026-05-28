enum PetType: String, CaseIterable, Codable {
    case dog, cat
}

//TODO: убрать это расширение
extension PetType {
    func toDTO() -> PetTypeDTO {
        switch self {
        case .dog: return .dog
        case .cat: return .cat
        }
    }
}
