import SwiftUI

final class PetRepository {
    private let service: PetService
    private let storage: PetStorage
    
    init(service: PetService, storage: PetStorage) {
        self.service = service
        self.storage = storage
    }
    
    func createPet(input: CreatePetInput) async throws -> Pet {
        let request = PetRequestMapper.map(input: input)
        let response = try await service.create(request)
        let pet = PetMapper.map(response: response)
    
        storage.appendPet(pet)
        
        return pet
    }
    
    func fetchById(ownerUUID: UUID, petId: Int) async throws -> Pet {
        let response = try await service.fetchById(ownerUUID: ownerUUID, petId: petId)
        let pet = PetMapper.map(response: response)
        
        storage.appendPet(pet)
        
        return pet
    }
    
    func getPets() -> [Pet] {
        storage.pets
    }
}
