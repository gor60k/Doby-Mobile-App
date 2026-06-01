import Observation

@MainActor
@Observable
final class ChatRepository: ChatRepositoryProtocol {
    private var api: ChatAPIProtocol
    private var storage: ChatStorage
    
    private var chatId: Int64
    
    init(
        api: ChatAPIProtocol,
        storage: ChatStorage,
        chatId: Int64
    ) {
        self.api = api
        self.storage = storage
        self.chatId = chatId
    }
    
    func getChat(with id: Int) async throws {
        let response = try await api.getChat(with: id)

        let payload = ChatMapper.map(dto: response)
        chatId = payload.chat.id

        try await storage.sync(
            chat: payload.chat,
            participants: payload.participants,
            messages: payload.messages
        )
    }
    
    func sendMessage(_ input: MessageInput) async throws {
        let request = MessageRequestMapper.map(input: input)
        let response = try await api.sendMessage(request)

        let message = MessageMapper.mapToRecord(dto: response, chatId: chatId)

        try await storage.saveMessage(message)
    }
}
