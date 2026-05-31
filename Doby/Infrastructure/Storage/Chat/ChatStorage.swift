import Foundation
import Observation
import GRDB

@MainActor
@Observable
final class ChatStorage {
    
    var chats: [ChatRecord] = []
    var messages: [MessageRecord] = []
    var participants: [UserRecord] = []
    private var observationTask: Task<Void, Never>?
    private var chatsObservationTask: Task<Void, Never>?
    private var participantsObservationTask: Task<Void, Never>?
    private var currentChatID: Int64?
    
    private let actor: ChatStorageActor
    
    init(actor: ChatStorageActor) {
        self.actor = actor
    }
    
    func start(chatID: Int64) {
        guard currentChatID != chatID else { return }
        
        stop()
        currentChatID = chatID
        
        chatsObservationTask = Task { [weak self] in
            guard let self else { return }

            do {
                for try await chats in await actor.observeChats() {
                    if Task.isCancelled { return }
                    self.chats = chats
                }
            } catch {
                if !Task.isCancelled {
                    print("Chats observation error:", error)
                }
            }
        }

        participantsObservationTask = Task { [weak self] in
            guard let self else { return }

            do {
                for try await users in await actor.observeParticipants(from: chatID) {
                    guard self.currentChatID == chatID else { return }
                    if Task.isCancelled { return }

                    self.participants = users
                }
            } catch {
                if !Task.isCancelled {
                    print("Participants observation error:", error)
                }
            }
        }
        
        observationTask = Task { [weak self] in
            guard let self else { return }
            
            do {
                for try await messages in await actor.observeMessages(from: chatID) {
                    guard self.currentChatID == chatID else { return }
                    if Task.isCancelled { return }
                    
                    self.messages = messages
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
        
        chatsObservationTask?.cancel()
        chatsObservationTask = nil

        participantsObservationTask?.cancel()
        participantsObservationTask = nil
        
        currentChatID = nil
        messages = []
        participants = []
    }
    
//    deinit {
//        observationTask?.cancel()
//    }
}
