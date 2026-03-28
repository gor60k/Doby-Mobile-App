import Foundation

struct SitterProfile: Decodable, Encodable {
    let experience_years: Int
    let price_per_hour: Int
    let is_verified: Bool
}
