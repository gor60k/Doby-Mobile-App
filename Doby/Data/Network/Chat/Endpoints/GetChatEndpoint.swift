import Foundation

struct GetChatEndpoint: APIEndpointProtocol {
    typealias Response = ChatDTO
    
    let chatId: Int
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/chat/\(chatId)/" }
    var method: HTTPMethod { .get }
}
