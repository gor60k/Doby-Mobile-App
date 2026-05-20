import Foundation

struct PetRequest: Encodable {
    let pet_type: PetTypeDTO
    let uploaded_photos: [Data]
    let name: String
    let age: Int
    let height: Int?
    let weight: Int?
    let breed_name: String
    let diet_type: String?
    let diet_pattern: String?
    let diet_additional_info: String?
    let warning_tags: [String]
    let specific_features: [String]
}
