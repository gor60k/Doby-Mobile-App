import Foundation
import Observation

@Observable
final class UserRepository: UserRepositoryProtocol {
    private var api: UserAPIProtocol
    private var userStorage: UserStorageProtocol
    private var petStorage: PetStorageProtocol
    private var cityStorage: CityStorageProtocol
    
    init(
        api: UserAPIProtocol,
        userStorage: UserStorageProtocol,
        petStorage: PetStorageProtocol,
        cityStorage: CityStorageProtocol
    ) {
        self.api = api
        self.userStorage = userStorage
        self.petStorage = petStorage
        self.cityStorage = cityStorage
    }
    
    func fetchUser() async throws {
        let response = try await api.me()
        let user = UserMapper.map(dto: response)
        
        userStorage.user = user
    }
    
    func updateUser(input: UpdateUserInput) async throws {
        let request = UpdateUserRequestMapper.map(input: input)
        let response = try await api.update(request)
        let user = UserMapper.map(dto: response)
        
        userStorage.update { currentUser in
            currentUser.firstName = user.firstName
            currentUser.lastName = user.lastName
            currentUser.patronymic = user.patronymic
            currentUser.phone = user.phone
            currentUser.avatar = user.avatar
            currentUser.city = user.city
            currentUser.bio = user.bio
        }
    }
    
    func fetchCities() async throws {
        let response = try await api.cities()
        let cities = CityMapper.map(dto: response)
        
        cityStorage.cities = cities
    }
}
