final class MockPetRepository: PetRepositoryProtocol {
    
    private(set) var pets: [Pet] = []
    
    init() {}
    
    func createPet(input: CreatePetInput) async throws -> Pet {
           return Pet(
                id: 0,
                petType: .dog,
                ownerUUID: "",
                name: "",
                age: 0,
                gender: .female,
                height: 0,
                weight: 0,
                breedName: "",
                dietType: "",
                dietPatterns: "",
                warningTags: [],
                specificTags: [],
                additionalInfo: "",
                dietAdditionalInfo: "",
                photos: []
            )
    }
    
    func fetchPets(from ownerUUID: String) async throws -> [Pet] { return
        [
            Pet(
                id: 0,
                petType: .dog,
                ownerUUID: "",
                name: "",
                age: 0,
                gender: .female,
                height: 0,
                weight: 0,
                breedName: "",
                dietType: "",
                dietPatterns: "",
                warningTags: [],
                specificTags: [],
                additionalInfo: "",
                dietAdditionalInfo: "",
                photos: []
            )
        ]
    }
    
    func fetchPet(with petId: Int, from ownerUUID: String) async throws -> Pet {
        return Pet(
                id: 0,
                petType: .dog,
                ownerUUID: "",
                name: "",
                age: 0,
                gender: .female,
                height: 0,
                weight: 0,
                breedName: "",
                dietType: "",
                dietPatterns: "",
                warningTags: [],
                specificTags: [],
                additionalInfo: "",
                dietAdditionalInfo: "",
                photos: []
            )
    }
    
    func deletePet(id: Int) async throws {}
    
    func updatePet(_ input: UpdatePetInput, with petId: Int) async throws {}
    
    func uploadPetPhoto(_ input: PetPhotoInput, with petId: Int) async throws {}
}
