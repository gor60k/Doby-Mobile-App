extension AppContainer {
    // MARK: - Profile
    func makeProfileViewModel(with target: ProfileTarget) -> ProfileViewModel {
        ProfileViewModel(
            userRepository: userRepository,
            petRepository: petRepository,
            target: target
        )
    }
    
    func makeProfilePetsViewModel() -> ProfilePetsViewModel {
        ProfilePetsViewModel(petRepository: petRepository)
    }
    
    func makeProfileOrdersViewModel() -> ProfileOrdersViewModel {
        ProfileOrdersViewModel()
    }
}
