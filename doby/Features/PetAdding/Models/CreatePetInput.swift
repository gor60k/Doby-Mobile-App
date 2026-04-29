struct CreatePetInput {
    let petType: PetType
    let uploadedPhotos: [String]
    let name: String
    let age: Int
    let height: Int?
    let weight: Int?
    let breedName: String
    let dietType: String?
    let dietPattern: String?
    let dietAdditionalInfo: String?
    let warningTags: [String]
    let specificTags: [String]
}
