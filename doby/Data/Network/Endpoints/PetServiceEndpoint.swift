import Foundation

struct CreateEndpoint: AuthorizedAPIEndpointProtocol {
    typealias Response = PetResponse
    
    let request: PetRequest
    var builder = MultypartFormDataBuilder()
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/" }
    var method: HTTPMethod { .post }
    var body: Data? {
        builder.addField(name: "pet_type", value: request.pet_type.rawValue)
        builder.addField(name: "name", value: request.name)
        builder.addField(name: "age", value: "\(request.age)")
        
        request.warning_tags.forEach {
            builder.addField(name: "warning_tags", value: $0)
        }
        
        request.specific_features.forEach {
            builder.addField(name: "specific_features", value: $0)
        }
        
        return builder.build()
    }
    var additionalHeaders: [String: String] {
        ["Content-Type" : builder.contentType]
    }
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

struct DeleteEndpoint: AuthorizedAPIEndpointProtocol {
    typealias Response = EmptyResponse
    
    let petId: Int
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/\(petId)" }
    var method: HTTPMethod { .delete }
    var body: Data? { nil }
}
