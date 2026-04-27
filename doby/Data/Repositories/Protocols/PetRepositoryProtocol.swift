import SwiftUI

protocol PetRepositoryProtocol {
    func createPet(input: CreatePetInput) async throws -> Pet
    func fetchPet(ownerUUID: UUID, petId: Int) async throws -> Pet
    func getPets() -> [Pet]
}
