import Foundation
import Observation

@MainActor
@Observable
final class ChatViewModel {
    private let storage: ChatStorage
    private let socket :WebSocketService
    
//    var messages: [Message] { storage.messages }
    
    let chatId: Int64
    
    init(
        storage: ChatStorage,
        socket: WebSocketService,
        chatId: Int64
    ) {
        self.storage = storage
        self.socket = socket
        self.chatId = chatId
    }
    
    func start() {
        storage.start(chatID: chatId)
        
        socket.connect()
        
//        socket.onMessage = { [weak self] message in
//            Task {
//                await self?.handleIncoming(message)
//            }
//        }
    }
}
