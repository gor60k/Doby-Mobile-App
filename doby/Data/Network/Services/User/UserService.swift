import Foundation
import Observation

//TODO: - переделать этот сервис под актуальнуб логику сети
@Observable
final class UserService: UserServiceProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func me() async throws -> UserDTO {
        try await apiClient.request(MeEndpoint())
    }
    
    func update(_ request: UpdateUserRequest) async throws -> UserDTO {
        try await apiClient.request(UpdateUser(request: request))
    }
    
    func cities() async throws -> [CityDTO] {
        try await apiClient.request(CitiesEndpoint())
    }
}
