extension AppContainer {
    // MARK: - Profile
    func makeProfileViewModel(with target: ProfileTarget) -> ProfileViewModel {
        ProfileViewModel(
            viewContextService: viewContextService,
            userRepository: userRepository,
            petRepository: petRepository,
            chatRepository: chatRepository,
            storage: userStorage,
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
