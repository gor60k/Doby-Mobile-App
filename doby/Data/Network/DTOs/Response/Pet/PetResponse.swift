import Foundation

struct PetResponse: Codable {
    let id: Int
    let pet_type: PetTypeDTO
    let pet_type_display: String
    let name: String
    let age: Int
    let owner_uuid: UUID
    let height: Int
    let weight: Int
    let breed_name: String
}

extension PetResponse {
    func toDomain() -> Pet {
        Pet(
            id: id,
            petType: pet_type.toDomain(),
            name: name,
            age: age,
            ownerUUID: owner_uuid,
            height: height,
            weight: weight,
            breedName: breed_name
        )
    }
}
