@MainActor
struct ServiceContainer {
    let sessionService: SessionService
    let keychainService: KeychainService
    let logService: LogService
}
