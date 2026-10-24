protocol UserRepositoryProtocol {
    func getMe() async throws -> User
    func getUser(with uuid: String) async throws -> User
    func updateMe(_ input: UpdateUserInput) async throws
    func getCities() async throws -> [City]
    func uploadPhoto(_ input: PhotoInput) async throws
}
