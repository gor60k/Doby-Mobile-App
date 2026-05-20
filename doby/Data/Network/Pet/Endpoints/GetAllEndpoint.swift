import Foundation

struct FetchAllEndpoint: APIEndpointProtocol {
    typealias Response = [PetResponse]
    
    let ownerUUID: String
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/\(ownerUUID)/all/" }
    var method: HTTPMethod { .get }
}

