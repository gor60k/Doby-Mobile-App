import SwiftUI

extension View {
    func withAppEnvironment() -> some View {
        self
            .environment(AppRouter())
            .environment(ThemeService())
            .environment(PrimaryColorService())
            .environment(SessionService.shared)
    }
}
