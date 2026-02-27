protocol UserServiceProtocol {
    func fetchAllUsers() async throws -> [User]
    func fetchUser(id: String) async throws -> User
}
