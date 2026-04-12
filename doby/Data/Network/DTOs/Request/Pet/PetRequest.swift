import Foundation

struct PetRequest: Encodable {
    let pet_type: PetTypeDTO
    let name: String
    let age: Int
    let height: Int
    let weight: Int
    let breed_name: String
}
