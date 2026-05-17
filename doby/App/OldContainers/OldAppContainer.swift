//import Observation
//
//@Observable
//final class OldAppContainer {
//    let infrastructure: OldInfrastructureContainer
//    let network: OldNetworkContainer
//    let auth: OldAuthContainer
//    let pet: OldPetContainer
//    let user: OldUserContainer
//    
//    init() {
//        self.infrastructure = OldInfrastructureContainer()
//        self.network = OldNetworkContainer(infrastructure: infrastructure)
//        self.auth = OldAuthContainer(
//            apiClient: network.apiClient,
//            sessionService: infrastructure.sessionService,
//            keychainService: infrastructure.keychainService
//        )
//        self.pet = OldPetContainer(apiClient: network.apiClient)
//        self.user = OldUserContainer(apiClient: network.apiClient)
//    }
//}
