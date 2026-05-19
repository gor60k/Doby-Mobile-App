import Observation

@MainActor
@Observable
final class StorageContainer<
    UserStorageType: UserStorageProtocol,
    PetStorageType: PetStorageProtocol,
    CityStorageType: CityStorageProtocol
> {
    let user: UserStorageType
    let pet: PetStorageType
    let city: CityStorageType
    
    init(
        user: UserStorageType,
        pet: PetStorageType,
        city: CityStorageType
    ) {
        self.user = user
        self.pet = pet
        self.city = city
    }
}
