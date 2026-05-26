import SwiftUI

struct SettingsStack: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(UserStorage.self) private var userStorage
    @Environment(CityStorage.self) private var cityStorage
    
    private var authRepository: AuthRepositoryProtocol { appContainer.authRepository }
    private var userRepository: UserRepositoryProtocol { appContainer.userRepository }
    private var ownerUUID: String { userStorage.user?.uuid ?? "" }
    
    @State private var settingsRouter = SettingsRouter()
    
    var body: some View {
        NavigationStack(path: $settingsRouter.path) {
            SettingsScreen(
                viewModel: appContainer.makeSettingsViewModel(),
                
                openSettingsAppearance: { settingsRouter.push(.appearance) },
                openSettingsPrivacy: { settingsRouter.push(.privacy) },
                openSettingsNotifications: { settingsRouter.push(.notifications) }
            )
                .navigationDestination(for: SettingsRoute.self) { route in
                    switch route {
                    case .appearance:
                        SettingsAppearensScreen()
                    case .privacy:
                        SettingsPrivacyScreen()
                    case .notifications:
                        SettingsNotificationsScreen()
                    case .petSettings(let id):
                        PetSettingsScreen(
                            viewModel: appContainer.makePetSettingsViewModel(
                                petId: id,
                                ownerUUID: ownerUUID
                            ),
                            petId: id,
                            ownerUUID: ownerUUID,
                            openPetProfile: {}
                        )
                    }
                }
        }
        .environment(settingsRouter)
    }
}
