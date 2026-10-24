protocol UserAPIProtocol {
    func getMe() async throws -> UserDTO
    func getUser(with userUUID: String) async throws -> UserDTO
    func updateMe(_ request: UpdateUserRequest) async throws -> UserDTO
    func getCities() async throws -> [CityDTO]
    func uploadPhoto(_ request: PhotoRequest) async throws -> [PhotoDTO]
}
