import Foundation
import Observation

@Observable
final class PetAddingViewModel {
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
    private var petService: PetServiceProtocol
    
    private let accessToken = "accessToken"
    
    var pets: [Pet] = []
    
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
        
        print("PET ADDING START")
        
        do {
            let request = PetRequest(
                pet_type: petType.toDTO(),
                name: name,
                age: age,
                height: height,
                weight: weight,
                breed_name: breedName,
            )
            
            print("PET ADDING REQUEST SEND")
            
            guard let token = keychain.getToken(for: accessToken), !token.isEmpty else {
                errorMessage = "Не удалось получить access token"
                print("PET ADDING STOP: access token missing")
                isLoading = false
                return
            }

            let response = try await petService.create(
                request,
                headers: [
                    "Authorization": "Bearer \(token)"
                ]
            )
            
            session.appendPet(response.toDomain())
            pets = session.currentPets ?? []
            
            print("PET SAVED: \(response)")
            
        } catch {
            errorMessage = error.localizedDescription
            print("LOGIN ERR: \(error)")
            print("LOGIN ERR DESCRIPTION: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
