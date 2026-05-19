import SwiftUI

//TODO: - разобраться с маршрутизацией питев
struct ProfileStack: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(PetStorage.self) private var petStorage
    @Environment(UserStorage.self) private var userStorage
    @Environment(CityStorage.self) private var cityStorage
    
    private var authRepository: AuthRepositoryProtocol { appContainer.repositories.authRepository }
    private var userRepository: UserRepositoryProtocol { appContainer.repositories.userRepository }
    private var petRepository: PetRepositoryProtocol { appContainer.repositories.petRepository }
    
    @State private var profileRouter = ProfileRouter()
    @State private var petRouter = PetRouter()
    
    var body: some View {
        NavigationStack(path: $profileRouter.path) {
            ProfileView(
                userRepository: userRepository,
                petRepository: petRepository,
                storage: userStorage,
                openSettings: { profileRouter.push(.settings) },
                openPetAdding: { profileRouter.push(.petAdding) },
                opentPetProfile: { id in
                    profileRouter.push(.petProfile(id: id))
                }
            )
                .navigationDestination(for: ProfileRoute.self) { route in
                    switch route {
                    case .settings:
                        SettingsView(
                            authRepository: authRepository,
                            userRepository: userRepository,
                            userStorage: userStorage,
                            cityStorage: cityStorage,
                            openSettingsAppearance: { profileRouter.push(.settingsAppearance) },
                            openSettingsPrivacy: { profileRouter.push(.settingsPrivacy) },
                            openSettingsNotifications: { profileRouter.push(.settingsNotifications) }
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
                            petId: id,
                            openSettings: { id in
                                profileRouter.push(.petSettings(id: id))
                            }
                        )
                    case .petAdding:
                        PetAddingView(repository: petRepository)
                    }
                }
        }
        .environment(profileRouter)
        .environment(petRouter)
    }
}
