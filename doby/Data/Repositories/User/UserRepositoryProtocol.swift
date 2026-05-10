import Foundation

protocol UserRepositoryProtocol {
    func getCurrentUser() -> User?
    func fetchUser() async throws
}
