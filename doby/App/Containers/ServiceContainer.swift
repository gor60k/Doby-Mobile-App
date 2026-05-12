@MainActor
struct ServiceContainer {
    let authService: AuthService
    let sessionService: SessionService
    let keychainService: KeychainService
    let logService: LogService
}
