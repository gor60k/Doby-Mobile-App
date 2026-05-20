extension AppContainer {
    // MARK: - PetView
    func makePetViewModel() -> PetViewModel {
        PetViewModel(
            repository: petRepository,
            storage: petStorage
        )
    }
    
    // MARK: - PetAdding
    func makePetAddingViewModel() -> PetAddingViewModel {
        PetAddingViewModel(repository: petRepository)
    }
    
    // MARK: - PetProfile
    func makePetProfileViewModel(petId: Int) -> PetProfileViewModel {
        PetProfileViewModel(
            repository: petRepository,
            userStorage: userStorage,
            petStorage: petStorage,
            petId: petId
        )
    }
}
