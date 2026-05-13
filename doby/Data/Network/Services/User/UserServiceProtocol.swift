protocol UserServiceProtocol {
    func me() async throws -> UserDTO
    func update(_ request: UpdateUserRequest) async throws -> UserDTO
}
