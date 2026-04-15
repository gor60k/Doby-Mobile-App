import Foundation

struct CreateEndpoint: AuthorizedAPIEndpointProtocol {
    typealias Response = PetResponse
    
    let request: PetRequest
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
}

struct FetchByIdEndpoint: AuthorizedAPIEndpointProtocol {
    typealias Response = PetResponse
    
    let ownerUUID: UUID
    let petId: Int
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/\(ownerUUID)/\(petId)" }
    var method: HTTPMethod { .get }
    var body: Data? { nil }
}
