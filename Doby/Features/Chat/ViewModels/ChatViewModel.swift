import Foundation
import Observation

@MainActor
@Observable
final class ChatViewModel {
    private let storage: ChatStorage
    
    var messages: [Message] { storage.messages }
    
    init(storage: ChatStorage) {
        self.storage = storage
    }
}
