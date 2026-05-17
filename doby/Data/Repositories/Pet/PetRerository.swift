import SwiftUI
import Foundation
import Observation

@MainActor
@Observable
final class PetRepository: PetRepositoryProtocol {
    private var service: PetServiceProtocol
    private var storage: PetStorage
    
    private(set) var pets: [Pet] = []
    
    init(
        service: PetServiceProtocol,
        storage: PetStorage
    ) {
        self.service = service
        self.storage = storage
        
        self.pets = storage.pets
    }
    
    func createPet(input: CreatePetInput) async throws {
        let request = PetRequestMapper.map(input: input)
        let response = try await service.create(request)
        let pet = PetMapper.map(response: response)
        
        storage.update(pet)
        self.pets.append(pet)
    }
    
    func fetchPets(ownerUUID: String) async throws {
        let response = try await service.fetchAll(ownerUUID)
        let pets = PetMapper.map(response: response)
        
        storage.set(pets)
        self.pets = pets
    }
    
    func fetchPet(ownerUUID: String, petId: Int) async throws {
        let response = try await service.fetchById(ownerUUID: ownerUUID, petId: petId)
        let pet = PetMapper.map(response: response)
        
        storage.update(pet)
        self.pets.append(pet)
    }
    
    func deletePet(id: Int) async throws {
        _ = try await service.delete(id)
        
        storage.remove(id: id)
        self.pets.removeAll { $0.id == id }
    }
}

