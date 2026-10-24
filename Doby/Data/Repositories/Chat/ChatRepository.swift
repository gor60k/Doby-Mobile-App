//import Observation
//
//@MainActor
//@Observable
//final class ChatRepository: ChatRepositoryProtocol {
//    private var api: ChatAPIProtocol
//    private var storage: ChatStorage
//    
//    private var chatId: Int64?
//    
//    init(
//        api: ChatAPIProtocol,
//        storage: ChatStorage,
//    ) {
//        self.api = api
//        self.storage = storage
//    }
//    
//    func creageChat(_ input: CreateChatInput) async throws {
//        let request = ChatMapper.mapToRequest(from: input)
//        let response = try await api.createChat(request)
//        
//        let payload = ChatMapper.mapToPayload(dto: response)
//        
//        try await storage.sync(
//            chat: payload.chat,
//            participants: payload.participants,
//            messages: payload.messages
//        )
//    }
//    
//    func getChat(with id: Int) async throws {
//        let response = try await api.getChat(with: id)
//
//        let payload = ChatMapper.mapToPayload(dto: response)
//        chatId = payload.chat.id
//
//        try await storage.sync(
//            chat: payload.chat,
//            participants: payload.participants,
//            messages: payload.messages
//        )
//    }
//    
//    func sendMessage(_ input: MessageInput) async throws {
//        guard let chatId else { return }
//        
//        let request = MessageRequestMapper.map(input: input)
//        let response = try await api.sendMessage(request)
//        
//        let message = MessageMapper.mapToRecord(dto: response, chatId: chatId)
//
//        try await storage.saveMessage(message)
//    }
//}
