protocol UserServiceProtocol {
    func me() async throws -> UserDTO
}
