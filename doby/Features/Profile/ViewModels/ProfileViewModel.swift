import Foundation
import Observation

@MainActor
@Observable
class ProfileViewModel {
    private let userRepository: UserRepositoryProtocol
    private let petRepository: PetRepositoryProtocol
    
    var user: User? { userRepository.user }
    
    var isLoading = false
    var error: String?
    
    init(
        userRepository: UserRepositoryProtocol,
        petRepository: PetRepositoryProtocol
    ) {
        self.userRepository = userRepository
        self.petRepository = petRepository
    }
    
    func fetchUser() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await userRepository.fetchUser()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func fetchPets() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await petRepository.fetchPets(ownerUUID: user?.uuid ?? "")
        } catch {
            self.error = error.localizedDescription
        }
    }
}
