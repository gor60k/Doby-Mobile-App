import Observation

@MainActor
@Observable
final class StorageContainer<
    UserStorageType: UserStorageProtocol,
    PetStorageType: PetStorageProtocol
> {
    let user: UserStorageType
    let pet: PetStorageType
    
    init(
        user: UserStorageType,
        pet: PetStorageType
    ) {
        self.user = user
        self.pet = pet
    }
}
