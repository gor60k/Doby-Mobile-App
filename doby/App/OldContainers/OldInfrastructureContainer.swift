import Alamofire

final class OldInfrastructureContainer {
    lazy var monitors = [NetworkLogService()]
    lazy var session: Session = Session(eventMonitors: monitors)
    lazy var tokenManager: TokenManager = TokenManager()
    lazy var keychainService: KeychainService = KeychainService.shared
    lazy var sessionService: SessionService = SessionService.shared
    lazy var userStorage: UserStorage = UserStorage.shared
    lazy var petStorage: PetStorage = PetStorage.shared
}
