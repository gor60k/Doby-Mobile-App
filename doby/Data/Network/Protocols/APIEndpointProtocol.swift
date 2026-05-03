import Foundation
import Alamofire

protocol APIEndpointProtocol: URLRequestConvertible {
    associatedtype Response: Decodable & Sendable
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    
    var isMultipart: Bool { get }
    func encodeMultipart(to formData: MultipartFormData)
}

extension APIEndpointProtocol {
    var headers: [String: String]? { nil }
    var body: Data? { nil }
    var isMultipart: Bool { false }
    
    func encodeMultipart(to formData: MultipartFormData) {}
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        return request
    }
}
