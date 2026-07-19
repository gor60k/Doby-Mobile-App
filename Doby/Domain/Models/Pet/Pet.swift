import Foundation

struct Pet: Codable, Identifiable {
    let id: Int
    let petType: PetType
    let ownerUUID: String
    let name: String
    let age: Int
    let gender: PetGender
    let height: Int
    let weight: Int
    let breedName: String
    let dietType: String
    let dietPatterns: String
    let warningTags: [String]
    let specificTags: [String]
    let additionalInfo: String
    let dietAdditionalInfo: String
    var photos: [PetPhoto]
}

extension Pet {
    static let placeholder = Pet(
        id: 0,
        petType: .dog,
        ownerUUID: "",
        name: "",
        age: 0,
        gender: .male,
        height: 0,
        weight: 0,
        breedName: "",
        dietType: "",
        dietPatterns: "",
        warningTags: [],
        specificTags: [],
        additionalInfo: "",
        dietAdditionalInfo: "",
        photos: []
    )
}
