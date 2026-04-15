import Foundation
import Combine
import os
import Observation

@Observable
final class PetAddingViewModel {
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
    private var petStorage = PetStorage.shared
    private var log = LogService.shared
    
    private var petService: PetServiceProtocol
    
    private let logger = Logger(
        subsystem: "com.app.subsystem",
        category: "PetAddingViewModel"
    )
    
//    var pets: [Pet] = []
    
    var petType: PetType = .dog
    var name: String = ""
    var age: Int = 0
    var height: Int = 0
    var weight: Int = 0
    var breedName: String = ""
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(
        petService: PetServiceProtocol = PetService()
    ) {
        self.petService = petService
    }
    
    @MainActor
    func addPet() async {
        isLoading = true
        errorMessage = nil
        
        await log.logAsync("ADDPET", logger: logger) {
            let request = PetRequest(
                pet_type: petType.toDTO(),
                name: name,
                age: age,
                height: height,
                weight: weight,
                breed_name: breedName,
            )
            
            let response = try await petService.create(request)
            
            petStorage.appendPet(response.toDomain())
//            pets = session.currentPets ?? []
        }
        
        isLoading = false
    }
}
