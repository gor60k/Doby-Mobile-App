protocol ChatRepositoryProtocol {
    func creageChat(_ input: CreateChatInput) async throws
    func getChat(with id: Int) async throws
    func sendMessage(_ input: MessageInput) async throws
}
