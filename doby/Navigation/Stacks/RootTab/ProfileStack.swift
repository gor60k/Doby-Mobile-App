import SwiftUI

struct ProfileStack: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(PetStorage.self) private var petStorage
    @Environment(UserStorage.self) private var userStorage
    @Environment(CityStorage.self) private var cityStorage
    
    private var authRepository: AuthRepositoryProtocol { appContainer.authRepository }
    private var userRepository: UserRepositoryProtocol { appContainer.userRepository }
    private var petRepository: PetRepositoryProtocol { appContainer.petRepository }
    private var ownerUUID: String { userStorage.user?.uuid ?? "" }
    
    @State private var profileRouter = ProfileRouter()
    @State private var petRouter = PetRouter()
    
    var body: some View {
        NavigationStack(path: $profileRouter.path) {
            ProfileView(
                viewModel: appContainer.makeProfileViewModel(),
                profilePetsViewModel: appContainer.makeProfilePetsViewModel(),
                profileOrdersViewModel: appContainer.makeProfileOrdersViewModel(),
                
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
                            viewModel: appContainer.makeSettingsViewModel(),
                            
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
                    case .petSettings(let id):
                        PetSettingsView(
                            viewModel: appContainer.makePetSettingsViewModel(
                                petId: id,
                                ownerUUID: ownerUUID
                            ),
                            petId: id,
                            ownerUUID: ownerUUID
                        )
                    case .petProfile(let id):
                        PetProfileView(
                            viewModel: appContainer.makePetProfileViewModel(petId: id),
                            
                            petId: id,
                            openSettings: { id in
                                profileRouter.push(.petSettings(id: id))
                            }
                        )
                    case .petAdding:
                        PetAddingView(viewModel: appContainer.makePetAddingViewModel())
                    }
                }
        }
        .environment(profileRouter)
    }
}
