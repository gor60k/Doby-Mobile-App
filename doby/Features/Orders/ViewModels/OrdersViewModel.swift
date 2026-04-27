import Foundation
import Observation

@MainActor
@Observable
final class OrdersViewModel {
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
            type: .walking,
            executorName: "Иван Смирнов",
            dateText: "6 апреля 2026",
            timeText: "09:00–09:30",
            serviceText: "Выгул",
            petName: "Молли",
            status: .inProgress
        ),
        Order(
            id: 2,
            type: .daycare,
            executorName: "Ольга Кузнецова",
            dateText: "6 апреля 2026",
            timeText: "10:00–18:00",
            serviceText: "Дневная передержка",
            petName: "Ричи",
            status: .completed
        ),
        Order(
            id: 3,
            type: .boarding,
            executorName: "Дмитрий Иванов",
            dateText: "7 апреля 2026",
            timeText: "12:00–16:00",
            serviceText: "Передержка",
            petName: "Луна",
            status: .canceled
        ),
        Order(
            id: 4,
            type: .walking,
            executorName: "Сергей Волков",
            dateText: "7 апреля 2026",
            timeText: "08:00–08:45",
            serviceText: "Утренний выгул",
            petName: "Бакс",
            status: .completed
        ),
        Order(
            id: 5,
            type: .daycare,
            executorName: "Мария Соколова",
            dateText: "8 апреля 2026",
            timeText: "09:00–19:00",
            serviceText: "Дневная передержка",
            petName: "Лаки",
            status: .inProgress
        )
    ]
}
