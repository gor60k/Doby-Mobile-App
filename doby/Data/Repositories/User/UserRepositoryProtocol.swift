import Foundation

protocol UserRepositoryProtocol {
    var user: User? { get }
    func fetchUser() async throws
    func updateUser(input: UpdateUserInput) async throws
}
