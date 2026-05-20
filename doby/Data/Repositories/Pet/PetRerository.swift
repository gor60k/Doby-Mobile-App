import SwiftUI
import Foundation
import Observation

@MainActor
@Observable
final class PetRepository: PetRepositoryProtocol {
    private var api: PetAPIProtocol
    private var storage: PetStorageProtocol
    
    init(
        api: PetAPIProtocol,
        storage: PetStorageProtocol
    ) {
        self.api = api
        self.storage = storage
    }
    
    func createPet(input: CreatePetInput) async throws {
        let request = PetRequestMapper.map(input: input)
        let response = try await api.create(request)
        let pet = PetMapper.map(response: response)
        
        storage.update(pet)
    }
    
    func fetchPets(ownerUUID: String) async throws {
        let response = try await api.fetchAll(ownerUUID)
        let pets = PetMapper.map(response: response)
        
        storage.set(pets)
    }
    
    func fetchPet(ownerUUID: String, petId: Int) async throws {
        let response = try await api.fetchById(ownerUUID: ownerUUID, petId: petId)
        let pet = PetMapper.map(response: response)
        
        storage.update(pet)
    }
    
    func deletePet(id: Int) async throws {
        _ = try await api.delete(id)
        
        storage.remove(id: id)
    }
}

