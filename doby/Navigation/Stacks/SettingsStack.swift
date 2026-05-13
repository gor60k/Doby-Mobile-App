import SwiftUI

struct SettingsStack: View {
    @Environment(\.appContainer) private var appContainer
    
    private var authRepository: AuthRepositoryProtocol { appContainer.repositories.authRepository }
    private var userRepository: UserRepositoryProtocol { appContainer.repositories.userRepository }
    
    private var userStorage: UserStorage { appContainer.storage.user }
    
    
    @State private var router = SettingsRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SettingsView(
                authRepository: authRepository,
                userRepository: userRepository,
                userStorage: userStorage
            )
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
