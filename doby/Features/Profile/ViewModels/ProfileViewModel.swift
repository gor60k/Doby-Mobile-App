import Foundation
import Observation

@MainActor
@Observable
class ProfileViewModel {
    private let userRepository: UserRepositoryProtocol
    private let petRepository: PetRepositoryProtocol
    
    var currentPage: Int = 0
    
//    var pets: [Pet] { petRepository.pets }
    var pets: [Pet] = []
    
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
    
    var orders = [
        Order(
            id: 0,
            type: .boarding,
            executorName: "Анна Петрова",
            dateText: "5 апреля 2026",
            timeText: "14:00–18:00",
            serviceText: "Передержка",
            petName: "Бруно",
            status: .completed
        ),
        Order(
            id: 1,
            type: .boarding,
            executorName: "Анна Петрова",
            dateText: "5 апреля 2026",
            timeText: "14:00–18:00",
            serviceText: "Передержка",
            petName: "Бруно",
            status: .completed
        ),
    ]
    
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
