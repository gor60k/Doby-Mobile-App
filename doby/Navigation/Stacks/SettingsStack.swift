import SwiftUI

struct SettingsStack: View {
    @Environment(\.appContainer) private var appContainer
    
    private var authRepository: AuthRepositoryProtocol { appContainer.repositories.authRepository }
    
    @State private var router = SettingsRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SettingsView(repository: authRepository)
                .navigationDestination(for: SettingsRoute.self) { route in
                    switch route {
                    case .appearance:
                        SettingsAppearensView()
                    case .privacy:
                        SettingsPrivacyView()
                    case .notifications:
                        SettingsNotificationsView()
                    case .petSettings:
                        PetSettingsView()
                    }
                }
        }
        .environment(router)
    }
}
