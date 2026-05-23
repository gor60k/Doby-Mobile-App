import Foundation
import Observation

@MainActor
@Observable
final class PetStorage {
    private let actor = PetStorageActor()
    
    var pets: [Pet] = []
    
    init(loadFromDisk: Bool = true) {
        guard loadFromDisk else { return }
        
        Task {
            await load()
        }
    }
    
    func load() async {
        let loaded = await actor.load()
        self.pets = loaded
    }
    
    func set(_ pets: [Pet]) {
        self.pets = pets
        persist()
    }
    
    func update(_ pet: Pet) {
        if let index = pets.firstIndex(where: { $0.id == pet.id }) {
            pets[index] = pet
        } else {
            pets.append(pet)
        }
        persist()
    }
    
    func remove(id: Int) {
        pets = pets.filter { $0.id != id }
        persist()
    }
    
    func clear() {
        pets.removeAll()
        persist()
    }
    
    private func persist() {
        let snapshot = pets
        Task {
            await actor.save(snapshot)
        }
    }
}

extension PetStorage {
    static var mock: PetStorage {
        let storage = PetStorage(loadFromDisk: false)
        
        storage.pets = [
            Pet(
                id: 1,
                petType: .dog,
                ownerUUID: "",
                name: "Варя",
                age: 4,
                gender: .female,
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
                additionalInfo: "Описание питомца",
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
        
        return storage
    }
}
