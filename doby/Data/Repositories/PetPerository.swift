import SwiftUI
import os

final class PetRepository: PetRepositoryProtocol {
    private let service: PetService
    private let storage: PetStorage
    private let logService: LogService
    
    init(
        service: PetService,
        storage: PetStorage,
        logService: LogService
    ) {
        self.service = service
        self.storage = storage
        self.logService = logService
    }
    
    func createPet(input: CreatePetInput) async throws -> Pet {
        let request = PetRequestMapper.map(input: input)
        let response = try await service.create(request)
        let pet = PetMapper.map(response: response)
    
        storage.appendPet(pet)
        
        return pet
    }
    
    func fetchPet(ownerUUID: UUID, petId: Int) async throws -> Pet {
        let response = try await service.fetchById(ownerUUID: ownerUUID, petId: petId)
        let pet = PetMapper.map(response: response)
        
        storage.appendPet(pet)
        
        return pet
    }
    
    func getPets() -> [Pet] {
        storage.pets
    }
    
    func deletePet(petId: Int) async throws -> EmptyResponse {
        let response = try await service.delete(petId)
        
        storage.removePet(by: petId)
        
        return response
    }
}
