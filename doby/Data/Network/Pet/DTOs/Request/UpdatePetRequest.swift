import Foundation

nonisolated
struct UpdatePetRequest: Codable {
    let pet_type: PetTypeDTO?
    let name: String?
    let age: Int?
    let sex: GenderDTO?
    let height: Int?
    let uploded_photos: [Data]?
    let weight: Int?
    let breed_name: String?
    let diet_type: String?
    let diet_pattern: String?
    let additional_info: String?
    let diet_additional_info: String?
    let warning_tags: [String]?
    let specific_features: [String]?
}
