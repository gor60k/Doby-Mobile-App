extension AppContainer {
    // MARK: - Profile
    func makeProfileViewModel(with target: ProfileTarget) -> ProfileViewModel {
        ProfileViewModel(
            viewContextService: viewContextService,
            currentUserProvider: userStorage,
            userRepository: userRepository,
            petRepository: petRepository,
//            chatRepository: chatRepository,
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
