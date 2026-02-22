protocol UserServiceProtocol {
    func fetchAllUsers() async throws -> [User]
    func fetchUser(id: String) async throws -> User
    func createUser(_ request: CreateUserRequestModel) async throws -> User
}
