import SwiftUI

protocol PetRepositoryProtocol {
    var pets: [Pet] { get }
    func createPet(input: CreatePetInput) async throws
    func fetchPets(ownerUUID: String) async throws
    func fetchPet(ownerUUID: String, petId: Int) async throws
    func deletePet(id: Int) async throws
}
