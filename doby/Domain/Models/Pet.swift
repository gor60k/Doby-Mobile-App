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
    let ownerUUID: UUID
    let name: String
    let age: Int
    let height: Int
    let weight: Int
    let breedName: String
    let dietType: String
    let dietPatterns: String
    let warningTags: [String]
    let specificTags: [String]
    let dietAdditionalInfo: String
    let photos: [PetPhoto]
}
