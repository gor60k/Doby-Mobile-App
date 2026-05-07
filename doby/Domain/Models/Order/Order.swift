import SwiftUI

struct Order: Hashable, Identifiable {
    let id: Int
    let type: OrderType
    let executorName: String
    let dateText: String
    let timeText: String
    let serviceText: String
    let petName: String
    let status: OrderStatus
}

enum OrderType: Hashable {
    case boarding
    case walking
    case daycare
}

enum OrderStatus: String, Hashable {
    case scheduled = "запланирован"
    case inProgress = "в процессе"
    case completed = "завершен"
    case canceled = "отменен"
}
