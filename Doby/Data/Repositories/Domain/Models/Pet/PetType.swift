enum PetType: String, CaseIterable, Codable {
    case dog, cat
    
    var displayName: String {
        switch self {
        case .dog: return "Собака"
        case .cat: return "Кошка"
        }
    }
}
