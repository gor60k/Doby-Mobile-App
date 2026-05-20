import Foundation

nonisolated
struct RefreshResponse: Codable, Sendable {
    let access: String
    let refresh: String
}
