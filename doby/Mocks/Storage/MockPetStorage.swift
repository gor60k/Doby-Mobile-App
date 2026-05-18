final class MockPetStorage {
    var pets: [Pet] = [
        Pet(
            id: 1,
            petType: .dog,
            ownerUUID: "",
            name: "Варя",
            age: 4,
            height: 20,
            weight: 6,
            breedName: "Вест Хайлен Уайт Терьер",
            dietType: "",
            dietPatterns: "",
            warningTags: ["Аллергия"],
            specificTags: ["Любит сыр"],
            dietAdditionalInfo: "",
            photos: [
                PetPhoto(
                    id: 1,
                    imageURL: "PetAvatarPlaceholder",
                    orderNumber: 1,
                    isMain: true
                )
            ]
        )
    ]
}
