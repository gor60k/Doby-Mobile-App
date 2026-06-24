import Foundation
import Observation

@Observable
final class UserAPI: UserAPIProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getMe() async throws -> UserDTO {
        try await apiClient.request(GetMeEndpoint())
    }
    
    func getUser(with userUUID: String) async throws -> UserDTO {
        try await apiClient.request(GetUserEndpoint(userUUID: userUUID))
    }
    
    func updateMe(_ request: UpdateUserRequest) async throws -> UserDTO {
        try await apiClient.request(UpdateMeEndpoint(request: request))
    }
    
    func getCities() async throws -> [CityDTO] {
        try await apiClient.request(GetCitiesEndpoint())
    }
    
    func uploadPhoto(_ request: UserPhotoRequest) async throws -> [UserPhotoDTO] {
        try await apiClient.request(UploadUserPhotoEndpoint(request: request))
    }
}
