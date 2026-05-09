import Foundation
import Observation

//TODO: - переделать этот сервис под актуальнуб логику сети
@Observable
final class UserService: UserServiceProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func me() async throws -> MeResponse {
        try await apiClient.request(MeEndpoint())
    }
}
