import SwiftUI

struct ProfileStack: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(PetStorage.self) private var petStorage
    @Environment(UserStorage.self) private var userStorage
    @Environment(CityStorage.self) private var cityStorage
    
    private var authRepository: AuthRepositoryProtocol { appContainer.repositories.authRepository }
    private var userRepository: UserRepositoryProtocol { appContainer.repositories.userRepository }
    private var petRepository: PetRepositoryProtocol { appContainer.repositories.petRepository }
    
    @State private var router = ProfileRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ProfileView(
                userRepository: userRepository,
                petRepository: petRepository,
                storage: userStorage
            )
                .navigationDestination(for: ProfileRoute.self) { route in
                    switch route {
                    case .settings:
                        SettingsView(
                            authRepository: authRepository,
                            userRepository: userRepository,
                            userStorage: userStorage,
                            cityStorage: cityStorage
                        )
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
                            repository: petRepository,
                            userStorage: userStorage,
                            petStorage: petStorage,
                            petId: id
                        )
                    case .petAdding:
                        PetAddingView(repository: petRepository)
                    }
                }
        }
        .environment(router)
    }
}
