import Observation

@Observable
final class AppContainer {
    let infrastructure: InfrastructureContainer
    let network: NetworkContainer
    let auth: AuthContainer
    let pet: PetContainer
    let user: UserContainer
    
    init() {
        self.infrastructure = InfrastructureContainer()
        self.network = NetworkContainer(infrastructure: infrastructure)
        self.auth = AuthContainer(
            apiClient: network.apiClient,
            sessionService: infrastructure.sessionService,
            keychainService: infrastructure.keychainService
        )
        self.pet = PetContainer(apiClient: network.apiClient)
        self.user = UserContainer(apiClient: network.apiClient)
    }
}
