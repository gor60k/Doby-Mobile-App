import Foundation
import Observation

@Observable
final class UserRepository: UserRepositoryProtocol {
    private var service: UserAPIProtocol
    private var userStorage: UserStorageProtocol
    private var petStorage: PetStorageProtocol
    private var cityStorage: CityStorageProtocol
    
    init(
        service: UserAPIProtocol,
        userStorage: UserStorageProtocol,
        petStorage: PetStorageProtocol,
        cityStorage: CityStorageProtocol
    ) {
        self.service = service
        self.userStorage = userStorage
        self.petStorage = petStorage
        self.cityStorage = cityStorage
    }
    
    func fetchUser() async throws {
        let response = try await service.me()
        let user = UserMapper.map(dto: response)
        
        userStorage.user = user
    }
    
    func updateUser(input: UpdateUserInput) async throws {
        let request = UpdateUserRequestMapper.map(input: input)
        let response = try await service.update(request)
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
        let response = try await service.cities()
        let cities = CityMapper.map(dto: response)
        
        cityStorage.cities = cities
    }
}
