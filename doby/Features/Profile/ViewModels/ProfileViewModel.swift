import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    
    var slides = [
        ProfilePetsSlide(id: 0, name: "Бобик", type: "Такса", age: 2, sex: "Мальчик", about: "Описание питомца"),
        ProfilePetsSlide(id: 1, name: "Бобик", type: "Такса", age: 2, sex: "Мальчик", about: "Описание питомца"),
        ProfilePetsSlide(id: 2, name: "Бобик", type: "Такса", age: 2, sex: "Мальчик", about: "Описание питомца")
    ]
}
