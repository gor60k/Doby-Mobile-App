import Foundation

struct CreateChatEndpoint: APIEndpointProtocol {
    typealias Response = ChatDTO
    
    let request: CreateChatRequest
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/chat/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
}
