import Foundation

struct FetchByIdEndpoint: APIEndpointProtocol {
    typealias Response = PetResponse
    
    let ownerUUID: String
    let petId: Int
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/\(ownerUUID)/\(petId)/" }
    var method: HTTPMethod { .get }
}
