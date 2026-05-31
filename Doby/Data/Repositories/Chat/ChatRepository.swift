import Observation

@MainActor
@Observable
final class ChatRepository: ChatRepositoryProtocol {
    private var api: ChatAPIProtocol
    private var storage: ChatStorage
    
    init(
        api: ChatAPIProtocol,
        storage: ChatStorage
    ) {
        self.api = api
        self.storage = storage
    }
    
    func getChat(with id: Int) async throws {
        let response = try await api.getChat(with: id)
        let chat = ChatMapper.map(dto: response)
        
        
    }
}
