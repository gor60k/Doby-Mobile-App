enum PetGender: String, CaseIterable, Codable {
    case male, female
    
    var displayName: String {
        switch self {
        case .male: return "Мальчик"
        case .female: return "Девочка"
        }
    }
}
