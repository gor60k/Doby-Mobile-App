import Observation

@Observable
final class StorageContainer {
    let user: UserStorage
    let pet: PetStorage
    
    init(
        user: UserStorage = UserStorage(),
        pet: PetStorage = PetStorage()
    ) {
        self.user = user
        self.pet = pet
    }
}
