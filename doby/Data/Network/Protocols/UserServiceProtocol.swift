protocol UserServiceProtocol {
    func fetchMe(headers: [String: String]?) async throws -> MeResponse
}
