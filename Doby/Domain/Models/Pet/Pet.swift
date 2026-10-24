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
    var photos: [Photo]
}
