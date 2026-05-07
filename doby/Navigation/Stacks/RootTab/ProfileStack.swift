import SwiftUI

struct ProfileStack: View {
    @Environment(AuthContainer.self) private var authContainer
    @Environment(UserContainer.self) private var userContainer
    @Environment(PetContainer.self) private var petContainer
    @Environment(UserStorage.self) private var userStorage
    
    @State private var router = ProfileRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ProfileView(
                userRepository: userContainer.repository,
                petRepository: petContainer.repository
            )
                .navigationDestination(for: ProfileRoute.self) { route in
                    switch route {
                    case .settings:
                        SettingsView(repository: authContainer.repository)
                    case .settingsAppearance:
                        SettingsAppearensView()
                    case .settingsPrivacy:
                        SettingsPrivacyView()
                    case .settingsNotifications:
                        SettingsNotificationsView()
                    case .petSettings:
                        PetSettingsView()
                    case .petProfile(let id):
                        PetProfileView(
                            repository: petContainer.repository,
                            userStorage: userStorage,
                            petId: id
                        )
                    case .petAdding:
                        PetAddingView(repository: petContainer.repository)
                    }
                }
        }
        .environment(router)
    }
}
