protocol UserServiceProtocol {
    func fetchAllUsers() async throws -> [User]
    func fetchUser(id: String) async throws -> User
    func createUser(_ request: CreateUserRequest) async throws -> User
}
