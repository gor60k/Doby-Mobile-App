import Foundation

struct GetCitiesEndpoint: APIEndpointProtocol {
    typealias Response = [CityDTO]
    
    var baseURL: URL {APIConstants.baseURL}
    var path: String { "/users/cities/" }
    var method: HTTPMethod { .get }
}
