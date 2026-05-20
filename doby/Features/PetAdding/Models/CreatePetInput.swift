import Foundation

struct CreatePetInput {
    let petType: PetType
    let uploadedPhotos: [Data]
    let name: String
    let age: Int
    let gender: Gender
    let height: Int?
    let weight: Int?
    let breedName: String
    let dietType: String?
    let dietPattern: String?
    let additionalInfo: String?
    let dietAdditionalInfo: String?
    let warningTags: [String]
    let specificTags: [String]
}
