protocol UserServiceProtocol {
    func fetchAllUsers() async throws -> [UserModel]
    func fetchUser(id: String) async throws -> UserModel
    func createUser(_ request: CreateUserRequestModel) async throws -> UserModel
}
