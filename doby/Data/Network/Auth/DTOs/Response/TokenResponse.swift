import Foundation

nonisolated
struct TokenResponse: Codable, Sendable {
    let access: String
    let refresh: String
}
