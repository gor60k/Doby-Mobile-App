import Foundation

final class MockUserRepository: UserRepositoryProtocol {
    
    var user: User? = User(uuid: "", username: "yeezus2013@gmail.com")
    
    init() {}
    
    func getMe() async throws -> User {
        return User(uuid: "", username: "")
    }
    
    func getUser(with uuid: String) async throws -> User {
        return User(uuid: "", username: "")
    }
    
    func updateMe(_ input: UpdateUserInput) async throws {}
    
    func getCities() async throws -> [City] {
        return [
            City(id: 0, name: "", translit: "")
        ]
    }
    
    func uploadPhoto(_ input: PhotoInput) async throws {}
}
