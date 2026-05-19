final class MockPetStorage: PetStorageProtocol {
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
            dietType: "Натуральное питание + сухой корм супер-премиум класса",
            dietPatterns: "Ест 2 раза в день, любит индейку и овощи, пьёт много воды, иногда выпрашивает лакомства",
            warningTags: [
                "Аллергия",
                "Чувствительное пищеварение",
                "Боится громких звуков",
                "Нельзя курицу",
                "Склонность к перееданию"
            ],
            specificTags: [
                "Любит сыр",
                "Обожает прогулки",
                "Спит только с игрушкой",
                "Дружелюбна к детям",
                "Знает команды"
            ],
            dietAdditionalInfo: "Аллергия на курицу. Нельзя сладкое и трубчатые кости. В период линьки принимает витамины для шерсти.",
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
    
    func load() async {}
    func set(_ pet: [Pet]) {}
    func update(_ pet: Pet) {}
    func remove(id: Int) {}
    func clear() {}
}
