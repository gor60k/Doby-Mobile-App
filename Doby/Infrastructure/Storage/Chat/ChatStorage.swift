import Foundation
import Observation
import GRDB

@MainActor
@Observable
final class ChatStorage {
    
    var messages: [Message] = []
    private var observationTask: Task<Void, Never>?
    private var currentChatID: Int64?
    
    private let actor: ChatStorageActor
    
    init(actor: ChatStorageActor) {
        self.actor = actor
    }
    
    func start(chatID: Int64) {
        guard currentChatID != chatID else { return }
        
        stop()
        currentChatID = chatID
        
        observationTask = Task { [weak self] in
            guard let self else { return }
            
            do {
                for try await messages in await actor.observeMessages(from: chatID) {
                    if Task.isCancelled { return }
                    
                    self.messages = messages.sorted {
                        $0.createdAt < $1.createdAt
                    }
                }
            } catch {
                if !Task.isCancelled {
                    print("Chat observation error:", error)
                }
            }
        }
    }
    
    func stop() {
        observationTask?.cancel()
        observationTask = nil
        currentChatID = nil
    }
    
//    deinit {
//        observationTask?.cancel()
//    }
}
