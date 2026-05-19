import SwiftUI

struct SettingsStack: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(UserStorage.self) private var userStorage
    @Environment(CityStorage.self) private var cityStorage
    
    private var authRepository: AuthRepositoryProtocol { appContainer.repositories.authRepository }
    private var userRepository: UserRepositoryProtocol { appContainer.repositories.userRepository }
    
    @State private var settingsRouter = SettingsRouter()
    
    var body: some View {
        NavigationStack(path: $settingsRouter.path) {
            SettingsView(
                authRepository: authRepository,
                userRepository: userRepository,
                userStorage: userStorage,
                cityStorage: cityStorage,
                openSettingsAppearance: { settingsRouter.push(.appearance) },
                openSettingsPrivacy: { settingsRouter.push(.privacy) },
                openSettingsNotifications: { settingsRouter.push(.notifications) }
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
        .environment(settingsRouter)
    }
}
