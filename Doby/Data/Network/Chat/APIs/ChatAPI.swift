import Foundation

final class ChatAPI: ChatAPIProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func createChat(_ request: CreateChatRequest) async throws -> ChatDTO {
        try await apiClient.request(CreateChatEndpoint(request: request))
    }
    
    func getChat(with id: Int) async throws -> ChatDTO {
        try await apiClient.request(GetChatEndpoint(chatId: id))
    }
    
    func sendMessage(_ request: MessageRequest) async throws -> MessageDTO {
        try await apiClient.request(SendMessageEndpoint(request: request))
    }
}
