import SwiftUI

struct Pet: Codable {
    let id: Int
    let petType: PetType
    var petTypeDisplay: String {
        switch petType {
        case .cat: return "Кошка"
        case .dog: return "Собака"
        }
    }
    let name: String
    let age: Int
    let ownerUUID: UUID
    let height: Int
    let weight: Int
    let breedName: String
}
