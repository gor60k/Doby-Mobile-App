import Observation

@MainActor
@Observable
final class StorageContainer {
    let user: UserStorage
    let pet: PetStorage
    
    init() {
        self.user = UserStorage()
        self.pet = PetStorage()
    }
}
