import Foundation

struct CreateEndpoint: APIEndpointProtocol {
    typealias Response = PetResponse
    
    let request: PetRequest
    let headersValue: [String: String]
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
    var headers: [String: String]? { headersValue }
}

struct FetchByIdEndpoint: APIEndpointProtocol {
    typealias Response = PetResponse
    
    let ownerUUID: UUID
    let petId: Int
    let headersValue: [String: String]
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/\(ownerUUID)/\(petId)" }
    var method: HTTPMethod { .get }
    var body: Data? { nil }
    var headers: [String: String]? { headersValue }
}

