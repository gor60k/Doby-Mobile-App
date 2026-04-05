import SwiftUI

struct Order: Hashable, Identifiable {
    let id: Int
    let executorName: String
    let dateText: String
    let timeText: String
    let serviceText: String
    let petName: String
    let statusText: String
}
