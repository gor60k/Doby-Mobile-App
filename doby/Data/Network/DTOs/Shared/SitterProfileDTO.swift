import Foundation

struct SitterProfileDTO: Decodable, Encodable {
    let experience_years: Int
    let price_per_hour: Int
    let is_verified: Bool
}

extension SitterProfileDTO {
    func toDomain() -> SitterProfile {
        SitterProfile(
            experienceYears: experience_years,
            pricePerHour: price_per_hour,
            isVerified: is_verified
        )
    }
}
