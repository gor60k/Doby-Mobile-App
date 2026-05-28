extension AppContainer {
    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(
            authRespository: authRepository,
            userRepository: userRepository,
            userStorage: userStorage,
            cityStorage: cityStorage
        )
    }
}
