protocol UserAPIProtocol {
    func me() async throws -> UserDTO
    func getUser(with userUUID: String) async throws -> UserDTO
    func update(_ request: UpdateUserRequest) async throws -> UserDTO
    func cities() async throws -> [CityDTO]
    func uploadPhoto(_ request: UserPhotoRequest) async throws -> [UserPhotoDTO]
}
