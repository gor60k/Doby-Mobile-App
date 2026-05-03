import Foundation

struct DeleteEndpoint: APIEndpointProtocol {
    typealias Response = EmptyDTO
    
    let petId: Int
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/\(petId)/" }
    var method: HTTPMethod { .delete }
}
