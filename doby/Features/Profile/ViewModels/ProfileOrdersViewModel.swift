import Observation

@MainActor
@Observable
final class ProfileOrdersViewModel {
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
