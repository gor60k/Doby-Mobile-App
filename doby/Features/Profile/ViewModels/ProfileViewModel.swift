import Foundation
import Observation

@MainActor
@Observable
class ProfileViewModel {
    private let repository: UserRepositoryProtocol
    private let petRepository: PetRepositoryProtocol
    
    var currentPage: Int = 0
    
    var pets: [Pet] {
        petRepository.pets
    }
    
    var user: User? {
        repository.getCurrentUser()
    }
    
    init(
        repository: UserRepositoryProtocol,
        petRepository: PetRepositoryProtocol
    ) {
        self.repository = repository
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
}
