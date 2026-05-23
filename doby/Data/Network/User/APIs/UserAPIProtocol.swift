protocol UserAPIProtocol {
    func me() async throws -> UserDTO
    func update(_ request: UpdateUserRequest) async throws -> UserDTO
    func cities() async throws -> [CityDTO]
}
