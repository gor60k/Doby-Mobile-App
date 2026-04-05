import SwiftUI

extension View {
    func withAppEnvironment() -> some View {
        self
            .environmentObject(AppRouter())
            .environmentObject(ThemeService())
            .environmentObject(PrimaryColorService())
            .environment(SessionService.shared)
    }
}
