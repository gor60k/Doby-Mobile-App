import Foundation

struct PetRequest: Encodable {
    let pet_type: PetTypeDTO
    let name: String
    let age: Int
    let warning_tags: [String]
    let specific_tags: [String]
}
