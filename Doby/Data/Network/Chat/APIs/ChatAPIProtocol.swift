protocol ChatAPIProtocol {
    func createChat(_ request: CreateChatRequest) async throws -> ChatDTO
    func getChat(with id: Int) async throws -> ChatDTO
    func sendMessage(_ request: MessageRequest) async throws -> MessageDTO
}
