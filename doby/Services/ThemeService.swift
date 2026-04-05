import SwiftUI
import Combine

final class ThemeService: ObservableObject {
    @AppStorage("theme") var storedTheme: String = AppTheme.system.rawValue
    
    var theme: AppTheme {
        get { AppTheme(rawValue: storedTheme) ?? .system }
        set { storedTheme = newValue.rawValue }
    }
    
    var colorScheme: ColorScheme? {
        switch theme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
