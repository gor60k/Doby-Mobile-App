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
    
    func createPet(input: CreatePetInput) async throws {
        let request = PetMapper.mapToRequest(from: input)
        let response = try await api.create(request)
        let pet = PetMapper.mapToDomain(from: response)
        
        storage.update(pet)
    }
    
    func fetchPets(from ownerUUID: String) async throws {
        let response = try await api.fetchAll(from: ownerUUID)
        let pets = PetMapper.mapToDomain(from: response)
        
        storage.set(pets)
    }
    
    func fetchPet(with petId: Int, from ownerUUID: String) async throws {
        let response = try await api.fetchPet(with: petId, from: ownerUUID)
        let pet = PetMapper.mapToDomain(from: response)
        
        storage.update(pet)
    }
    
    func deletePet(id: Int) async throws {
        _ = try await api.delete(id)
        
        storage.remove(id: id)
    }
    
    func updatePet(_ input: UpdatePetInput, with petId: Int) async throws {
        let request = UpdatePetMapper.mapToRequest(from: input)
        let response = try await api.updatePet(request, with: petId)
        let pet = PetMapper.mapToDomain(from: response)
        
        storage.update(pet)
    }
    
    func uploadPetPhoto(_ input: PetPhotoInput, with petId: Int) async throws {
        let request = PetPhotoMapper.mapToRequest(from: input)
        let response = try await api.uploadPetPhoto(request, with: petId)
        let petPhoto = PetPhotoMapper.mapToDomain(from: response)
        
        storage.patch(with: petId) { pet in
            pet.photos.append(petPhoto)
        }
    }
}

