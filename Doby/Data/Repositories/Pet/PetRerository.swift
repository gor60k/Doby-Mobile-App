import SwiftUI
import Foundation
import Observation

@MainActor
@Observable
final class PetRepository: PetRepositoryProtocol {
    private var api: PetAPIProtocol
    private var storage: PetStorage
    
    init(
        api: PetAPIProtocol,
        storage: PetStorage
    ) {
        self.api = api
        self.storage = storage
    }
    
    func createPet(input: CreatePetInput) async throws -> Pet {
        let request = PetMapper.mapToRequest(from: input)
        let response = try await api.create(request)
        let pet = PetMapper.mapToDomain(from: response)
        
        try await storage.update(pet)
        return pet
    }
    
    func fetchPets(from ownerUUID: String) async throws -> [Pet] {
        if let cached = storage.pets, !cached.isEmpty {
            return cached
        }
        
        let response = try await api.fetchAll(from: ownerUUID)
        let pets = PetMapper.mapToDomain(from: response)
        
        try await storage.set(pets)
        
        return pets
    }
    
    func fetchPet(with petId: Int, from ownerUUID: String) async throws -> Pet {
        if let cached = storage.pets?.first(where: { $0.id == petId }) {
            return cached
        }
        
        let response = try await api.fetchPet(with: petId, from: ownerUUID)
        let pet = PetMapper.mapToDomain(from: response)
        
        try await storage.update(pet)
        
        return pet
    }
    
    func deletePet(id: Int) async throws {
        _ = try await api.delete(id)
        
        try await storage.remove(id: id)
    }
    
    func updatePet(_ input: UpdatePetInput, with petId: Int) async throws {
        let request = UpdatePetMapper.mapToRequest(from: input)
        let response = try await api.updatePet(request, with: petId)
        let pet = PetMapper.mapToDomain(from: response)
        
        try await storage.update(pet)
    }
    
    func uploadPetPhoto(_ input: PetPhotoInput, with petId: Int) async throws {
        let request = PetPhotoMapper.mapToRequest(from: input)
        let response = try await api.uploadPetPhoto(request, with: petId)
        let petPhoto = PetPhotoMapper.mapToDomain(from: response)
        
        try await storage.patch(with: petId) { pet in
            pet.photos.append(petPhoto)
        }
    }
}

