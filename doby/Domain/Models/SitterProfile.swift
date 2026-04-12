import Foundation

struct SitterProfile: Decodable, Encodable {
    let experienceYears: Int
    let pricePerHour: Int
    let isVerified: Bool
}
