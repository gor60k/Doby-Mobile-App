import Foundation

protocol UserRepositoryProtocol {
    var user: User? { get }
    func getCurrentUser() -> User?
    func fetchUser() async throws
}
