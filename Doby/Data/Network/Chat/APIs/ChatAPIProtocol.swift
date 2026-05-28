protocol ChatAPIProtocol {
    func getChat(with id: Int) async throws -> ChatDTO
    func sendMessage(_ request: MessageRequest) async throws -> MessageDTO
}
