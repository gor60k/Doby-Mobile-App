import Foundation

struct PetSettingsForm {
    var petType: PetType
    var name: String
    var age: Int
    var gender: PetGender
    var breedName: String
    var height: Int
    var weight: Int
    var description: String
    var dietType: String
    var dietPatterns: String
    var dietAdditionalInfo: String
    var warningTags: [String]
    var featureTags: [String]
    
    // Фото для загрузки — отдельно от уже загруженных фото питомца
    var photosToUpload: [Data]
    
    // Дефолтный init (нужен для @Observable)
    init(
        petType: PetType = .dog,
        name: String = "",
        age: Int = 0,
        gender: PetGender = .male,
        breedName: String = "",
        height: Int = 0,
        weight: Int = 0,
        description: String = "",
        dietType: String = "",
        dietPatterns: String = "",
        dietAdditionalInfo: String = "",
        warningTags: [String] = [],
        featureTags: [String] = [],
        photosToUpload: [Data] = []
    ) {
        self.petType = petType
        self.name = name
        self.age = age
        self.gender = gender
        self.breedName = breedName
        self.height = height
        self.weight = weight
        self.description = description
        self.dietType = dietType
        self.dietPatterns = dietPatterns
        self.dietAdditionalInfo = dietAdditionalInfo
        self.warningTags = warningTags
        self.featureTags = featureTags
        self.photosToUpload = photosToUpload
    }
    
    // Init из модели Pet
    init(from pet: Pet) {
        self.petType = pet.petType
        self.name = pet.name
        self.age = pet.age
        self.gender = pet.gender
        self.breedName = pet.breedName
        self.height = pet.height
        self.weight = pet.weight
        self.description = pet.additionalInfo
        self.dietType = pet.dietType
        self.dietPatterns = pet.dietPatterns
        self.dietAdditionalInfo = pet.dietAdditionalInfo
        self.warningTags = pet.warningTags
        self.featureTags = pet.specificTags
        self.photosToUpload = []
    }
    
    func toUpdateInput() -> UpdatePetInput {
        UpdatePetInput(
            petType: petType,
            uploadedPhotos: photosToUpload.isEmpty ? nil : photosToUpload,
            name: name.nilIfEmpty,
            age: age.nilIfZero,
            gender: gender,
            height: height.nilIfZero,
            weight: weight.nilIfZero,
            breedName: breedName.nilIfEmpty,
            dietType: dietType.nilIfEmpty,
            dietPattern: dietPatterns.nilIfEmpty,
            additionalInfo: description.nilIfEmpty,
            dietAdditionalInfo: dietAdditionalInfo.nilIfEmpty,
            warningTags: warningTags,
            specificTags: featureTags
        )
    }
}
