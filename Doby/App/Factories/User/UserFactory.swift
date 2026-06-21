extension AppContainer {
    // MARK: - Profile
    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(
            userRepository: userRepository,
            petRepository: petRepository,
            storage: userStorage,
            displayModeService: displayModeService
        )
    }
    
    func makeProfilePetsViewModel() -> ProfilePetsViewModel {
        ProfilePetsViewModel(petRepository: petRepository)
    }
    
    func makeProfileOrdersViewModel() -> ProfileOrdersViewModel {
        ProfileOrdersViewModel()
    }
}
