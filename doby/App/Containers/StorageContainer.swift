import Observation

@MainActor
@Observable
final class StorageContainer {
    let user: UserStorage
    let pet: PetStorageProtocol
    
    init(pet: PetStorageProtocol) {
        self.user = UserStorage()
        self.pet = pet
    }
}
