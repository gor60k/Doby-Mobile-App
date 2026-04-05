import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    
    var slides = [
        ProfilePetsSlide(id: 0, name: "Бобик", type: "Такса", age: 2, sex: "Мальчик", about: "Описание питомца"),
        ProfilePetsSlide(id: 1, name: "Бобик", type: "Такса", age: 2, sex: "Мальчик", about: "Описание питомца"),
        ProfilePetsSlide(id: 2, name: "Бобик", type: "Такса", age: 2, sex: "Мальчик", about: "Описание питомца")
    ]
    
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
