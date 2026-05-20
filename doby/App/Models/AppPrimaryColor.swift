import SwiftUI

enum AppPrimaryColor: String, CaseIterable {
    case yellow = "Желтый"
    case green = "Зеленый"
    case blue = "Голубой"
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .yellow: return .primaryYellow
        case .blue: return .primaryBlue
        case .green: return .primaryGreen
        }
    }
}
