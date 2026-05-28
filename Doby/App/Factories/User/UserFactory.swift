extension AppContainer {
    // MARK: - Profile
    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(
            userRepository: userRepository,
            petRepository: petRepository,
            storage: userStorage
        )
    }
    
    func makeProfilePetsViewModel() -> ProfilePetsViewModel {
        ProfilePetsViewModel(petRepository: petRepository)
    }
    
    func makeProfileOrdersViewModel() -> ProfileOrdersViewModel {
        ProfileOrdersViewModel()
    }
}
