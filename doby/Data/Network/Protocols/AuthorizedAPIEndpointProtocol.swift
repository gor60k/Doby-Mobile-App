import Foundation

protocol AuthorizedAPIEndpointProtocol: APIEndpointProtocol {
    var tokenKey: String { get }
    var additionalHeaders: [String: String] { get }
}

extension AuthorizedAPIEndpointProtocol {
    var tokenKey: String { KeychainService.TokenKey.accessToken }
    var additionalHeaders: [String: String] { [:] }
    
    var headers: [String: String]? {
        let authHeaders = KeychainService.shared.authorizationHeaders(for: tokenKey)
        let mergedHeaders = authHeaders.merging(additionalHeaders) { _, new in new }
        return mergedHeaders.isEmpty ? nil : mergedHeaders
    }
}
