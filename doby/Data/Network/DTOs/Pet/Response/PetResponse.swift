import Foundation

nonisolated
struct PetResponse: Codable, Sendable {
    let id: Int
    let pet_type: PetTypeDTO
    let pet_type_display: String
    let owner_uuid: String
    let name: String
    let age: Int
    let height: Int?
    let weight: Int?
    let breed_name: String
    let diet_type: String
    let diet_pattern: String
    let warning_tags: [String]
    let specific_features: [String]
    let diet_additional_info: String
    let photos: [PetPhotoDTO]
}
