extension AppContainer {
    func makeAuthViewModel() -> AuthViewModel {
        AuthViewModel(repository: authRepository)
    }
}
