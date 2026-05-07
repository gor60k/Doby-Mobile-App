import Alamofire

final class InfrastructureContainer {
    lazy var session: Session = Session()
    lazy var tokenManager: TokenManager = TokenManager()
    lazy var keychainService: KeychainService = KeychainService.shared
    lazy var sessionService: SessionService = SessionService.shared
}
