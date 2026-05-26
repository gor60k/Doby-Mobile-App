import SwiftUI

enum PrimaryButtonSize {
    case large
    case medium
    case small
    
    var font: Font {
        switch self {
        case .large: return .system(.title2, design: .rounded)
        case .medium: return .system(.body, design: .rounded)
        case .small: return .system(.subheadline, design: .rounded)
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .large: return 14
        case .medium: return 10
        case .small: return 6
        }
    }
}
