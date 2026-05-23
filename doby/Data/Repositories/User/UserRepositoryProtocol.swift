import Foundation

protocol UserRepositoryProtocol {
    func fetchUser() async throws
    func updateUser(input: UpdateUserInput) async throws
    func fetchCities() async throws
}
