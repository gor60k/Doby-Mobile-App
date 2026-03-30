import SwiftUI

extension dobyApp {
    
    @ViewBuilder
    func destinationView(for route: AppRoute) -> some View {
        switch route {
        case .welcome: WelcomeView()
        case .role: RoleView()
        case .auth: AuthView()
        case .login: SignInView()
        case .rootTab: RootTabView()
        case .settings: SettingsView()
        }
    }
}
