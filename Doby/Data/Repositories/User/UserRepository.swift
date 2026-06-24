import Foundation
import Observation

@Observable
final class UserRepository: UserRepositoryProtocol {
    private var api: UserAPIProtocol
    private var userStorage: UserStorage
    private var petStorage: PetStorage
    private var cityStorage: CityStorage
    
    
    init(
        api: UserAPIProtocol,
        userStorage: UserStorage,
        petStorage: PetStorage,
        cityStorage: CityStorage
    ) {
        self.api = api
        self.userStorage = userStorage
        self.petStorage = petStorage
        self.cityStorage = cityStorage
    }
    
    func getMe() async throws -> User {
        if let cached = userStorage.user {
            return cached
        }
        
        let response = try await api.getMe()
        let user = UserMapper.mapToDomain(from: response)
        
        userStorage.save(user)
        return user
    }
    
    func getUser(with uuid: String) async throws -> User {
        let response = try await api.getUser(with: uuid)
        let user = UserMapper.mapToDomain(from: response)
        
        return user
    }
    
    func updateMe(_ input: UpdateUserInput) async throws {
        let request = UpdateUserMapper.mapToRequest(input: input)
        let response = try await api.updateMe(request)
        let user = UserMapper.mapToDomain(from: response)
        
        userStorage.update { currentUser in
            currentUser.firstName = user.firstName
            currentUser.lastName = user.lastName
            currentUser.patronymic = user.patronymic
            currentUser.phone = user.phone
            currentUser.city = user.city
            currentUser.bio = user.bio
        }
    }
    
    func getCities() async throws {
        let response = try await api.getCities()
        let cities = CityMapper.mapToDomain(from: response)
        
        cityStorage.cities = cities
    }
    
    func uploadPhoto(_ input: UserPhotoInput) async throws {
        let request = UserPhotoMapper.mapToRequest(from: input)
        let response = try await api.uploadPhoto(request)
        let photos = UserPhotoMapper.mapToDomain(from: response)
        
        userStorage.update { user in
            user.photos = photos
        }
    }
}
