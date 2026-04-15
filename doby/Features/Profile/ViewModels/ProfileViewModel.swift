import Foundation
import Combine

@MainActor
class ProfileViewModel: ObservableObject {
    private let userStorage = UserStorage.shared
    private let petStorage = PetStorage.shared
    
    @Published var currentPage: Int = 0
    @Published private(set) var pets: [Pet] = []
    @Published private(set) var user: User?
    
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
