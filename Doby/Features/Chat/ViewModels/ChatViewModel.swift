import Foundation
import Observation

@MainActor
@Observable
final class ChatViewModel {
    private let repository: ChatRepository
    private let storage: ChatStorage
    private let socket :WebSocketService
    
//    var messages: [Message] { storage.messages }
    
    let chatId: Int
    
    var isLoading = false
    var error: String?
    
    init(
        repository: ChatRepository,
        storage: ChatStorage,
        socket: WebSocketService,
        chatId: Int
    ) {
        self.repository = repository
        self.storage = storage
        self.socket = socket
        self.chatId = chatId
    }
    
    func start() {
        storage.start(chatID: Int64(chatId))
        
        socket.connect()
        
//        socket.onMessage = { [weak self] message in
//            Task {
//                await self?.handleIncoming(message)
//            }
//        }
    }
    
    func fetchChat() async {
        await perform {
            try await repository.getChat(with: chatId)
        }
    }
    
    private func perform(
        _ action: () async throws -> Void
    ) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await action()
        } catch {
            self.error = error.localizedDescription
        }
    }
}
