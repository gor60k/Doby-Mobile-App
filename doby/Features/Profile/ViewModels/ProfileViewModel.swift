import Foundation
import Observation

@MainActor
@Observable
class ProfileViewModel {
    private let userStorage = UserStorage.shared
    private let petStorage = PetStorage.shared
    
    var currentPage: Int = 0
    private(set) var pets: [Pet] = []
    private(set) var user: User?
    
    init() {
        loadUser()
        loadPets()
    }
    
    func loadUser() {
        user = userStorage.currentUser
    }
    
    func loadPets() {
        pets = petStorage.pets
    }
    
    var orders = [
        Order(
            id: 0,
            executorName: "Анна Петрова",
            dateText: "5 апреля 2026",
            timeText: "14:00–18:00",
            serviceText: "Передержка",
            petName: "Бруно",
            statusText: "Завершён"),
        Order(
            id: 1,
            executorName: "Анна Петрова",
            dateText: "5 апреля 2026",
            timeText: "14:00–18:00",
            serviceText: "Передержка",
            petName: "Бруно",
            statusText: "Завершён"),
    ]
}
