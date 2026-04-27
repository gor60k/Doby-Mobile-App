import Foundation

struct PetResponse: Codable {
    let id: Int
    let pet_type: PetTypeDTO
    let pet_type_display: String
    let owner_uuid: UUID
    let name: String
    let age: Int
    let height: Int
    let weight: Int
    let breed_name: String
    let diet_type: String
    let diet_patterns: String
    let warning_tags: [String]
    let specific_tags: [String]
    let diet_additional_info: String
    let photos: [PetPhotoDTO]
}
