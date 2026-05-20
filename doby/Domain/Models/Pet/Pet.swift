import Foundation

struct Pet: Codable, Identifiable {
    let id: Int
    let petType: PetType
    var petTypeDisplay: String {
        switch petType {
        case .cat: return "Кошка"
        case .dog: return "Собака"
        }
    }
    let ownerUUID: String
    let name: String
    let age: Int
    let gender: Gender
    var sex: String {
        switch gender {
        case .male: return "Мальчик"
        case .female: return "Девочка"
        }
    }
    let height: Int
    let weight: Int
    let breedName: String
    let dietType: String
    let dietPatterns: String
    let warningTags: [String]
    let specificTags: [String]
    let additionalInfo: String
    let dietAdditionalInfo: String
    let photos: [PetPhoto]
}
