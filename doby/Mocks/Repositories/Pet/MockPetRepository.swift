final class MockPetRepository: PetRepositoryProtocol {
    
    private(set) var pets: [Pet] = []
    
    init() {}
    
    func createPet(input: CreatePetInput) async throws {}
    
    func fetchPets(from ownerUUID: String) async throws {}
    
    func fetchPet(with petId: Int, from ownerUUID: String) async throws {}
    
    func deletePet(id: Int) async throws {}
    
    func updatePet(_ input: UpdatePetInput, with petId: Int) async throws {}
    
    func uploadPetPhoto(_ input: PetPhotoInput, with petId: Int) async throws {}
}
