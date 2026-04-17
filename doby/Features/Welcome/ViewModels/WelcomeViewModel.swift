import SwiftUI
import Observation

@Observable
class WelcomeViewModel {
    var currentPage: Int = 0
    
    let slides: [WelcomeSlide] = [
        WelcomeSlide(id: 0, title: "Найдите надежного ситтера", subtitle: "Просмотрите профили и выберете того, кому доверите любимца"),
        WelcomeSlide(id: 1, title: "Договоритесь в чате", subtitle: "Обсудите все детали ухода прямо в приложении"),
        WelcomeSlide(id: 2, title: "Оплатите безопасно", subtitle: "Используйте надежные встроенные платежи без риска")
    ]
    
    var isLastSlide: Bool {
        currentPage == slides.count - 1
    }
}
