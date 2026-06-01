protocol ChatRepositoryProtocol {
    func getChat(with id: Int) async throws
    func sendMessage(_ input: MessageInput) async throws
}
