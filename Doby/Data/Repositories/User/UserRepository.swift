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
            print("Возвращается кэш юзера")
            return cached
        }
        
        let response = try await api.getMe()
        let user = UserMapper.mapToDomain(from: response)
        
        try await userStorage.save(user)
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
        
        try await userStorage.patch { currentUser in
            currentUser.firstName = user.firstName
            currentUser.lastName = user.lastName
            currentUser.patronymic = user.patronymic
            currentUser.phone = user.phone
            currentUser.city = user.city
            currentUser.bio = user.bio
        }
    }
    
    func getCities() async throws -> [City] {
        if let cached = cityStorage.cities, !cached.isEmpty {
            return cached
        }
        
        let response = try await api.getCities()
        let cities = CityMapper.mapToDomain(from: response)
        
        await cityStorage.save(cities)
        return cities
    }
    
    func uploadPhoto(_ input: PhotoInput) async throws {
        let request = UserPhotoMapper.mapToRequest(from: input)
        let response = try await api.uploadPhoto(request)
        let photos = UserPhotoMapper.mapToDomain(from: response)
        
        try await userStorage.patch { user in
            user.photos = photos
        }
    }
}
