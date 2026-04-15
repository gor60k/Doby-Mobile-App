import Foundation

struct TokenResponse: Decodable, Encodable {
    let access: String
    let refresh: String
}
