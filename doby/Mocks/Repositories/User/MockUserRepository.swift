import Foundation

final class MockUserRepository: UserRepositoryProtocol {
    
    var user: User? = User(uuid: "", username: "yeezus2013@gmail.com")
    
    init() {}
    
    func fetchUser() async throws {}
    
    func updateUser(input: UpdateUserInput) async throws {}
    
    func fetchCities() async throws {}
}
