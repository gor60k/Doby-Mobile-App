import SwiftUI

struct SettingsStack: View {
    @Environment(\.appContainer) var appContainer
    @Environment(UserStorage.self) private var userStorage
    @Environment(CityStorage.self) private var cityStorage
    
    @State private var settingsRouter = SettingsRouter()
    
    private var authRepository: AuthRepositoryProtocol { appContainer.authRepository }
    private var userRepository: UserRepositoryProtocol { appContainer.userRepository }
    var ownerUUID: String { userStorage.user?.uuid ?? "" }
    
    // MARK: - структуры навигации
    var settingsNavigation: SettingsNavigation {
        SettingsNavigation(
            openSettingsAppearance: { settingsRouter.push(.appearance) },
            openSettingsPrivacy: { settingsRouter.push(.privacy) },
            openSettingsNotifications: { settingsRouter.push(.notifications) }
        )
    }
    
    // MARK: - тело стака
    var body: some View {
        NavigationStack(path: $settingsRouter.path) {
            createSettingsScreen()
                .navigationDestination(for: SettingsRoute.self) { route in
                    switch route {
                    case .appearance:
                        SettingsAppearensScreen()
                    case .privacy:
                        SettingsPrivacyScreen()
                    case .notifications:
                        SettingsNotificationsScreen()
                    case .petSettings(let id):
                        createPetSettingsScreen(petId: id)
                    }
                }
        }
        .environment(settingsRouter)
    }
}

// MARK: - фабрика экранов
extension SettingsStack {
    func createSettingsScreen() -> SettingsScreen {
        SettingsScreen(
            viewModel: appContainer.makeSettingsViewModel(),
            settingsNavigation: settingsNavigation
        )
    }
    
    func createPetSettingsScreen(petId: Int) -> PetSettingsScreen {
        PetSettingsScreen(
            viewModel: appContainer.makePetSettingsViewModel(
                petId: petId,
                ownerUUID: ownerUUID
            ),
            petId: petId,
            ownerUUID: ownerUUID,
            openPetProfile: {}
        )
    }
}
