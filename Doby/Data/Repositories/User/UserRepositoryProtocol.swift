import Foundation

protocol UserRepositoryProtocol {
    func fetchUser() async throws
    func getUser(with uuid: String) async throws -> User
    func updateUser(input: UpdateUserInput) async throws
    func fetchCities() async throws
    func uploadPhoto(_ input: UserPhotoInput) async throws
}
