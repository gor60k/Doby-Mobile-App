import Alamofire

@MainActor
struct InfrastructureContainer {
    let session: Session
    let tokenManager: TokenManager
}
