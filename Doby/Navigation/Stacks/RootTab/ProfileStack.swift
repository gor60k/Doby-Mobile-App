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
    
    private func openPetProfile() {
        profileRouter.pop()
    }
    
    var body: some View {
        NavigationStack(path: $profileRouter.path) {
            ProfileScreen(
                viewModel: appContainer.makeProfileViewModel(with: .currentUser),
                profilePetsViewModel: appContainer.makeProfilePetsViewModel(),
                profileOrdersViewModel: appContainer.makeProfileOrdersViewModel(),
                
                openSettings: { profileRouter.push(.settings) },
                openPetAdding: { profileRouter.push(.petAdding) },
                opentPetProfile: { id in
                    profileRouter.push(.petProfile(id: id))
                }
            )
            .environment(DisplayModeService(mode: .owner))
                .navigationDestination(for: ProfileRoute.self) { route in
                    switch route {
                    case .profile(let uuid):
                        ProfileScreen(
                            viewModel: appContainer.makeProfileViewModel(with: .user(uuid: uuid)),
                            profilePetsViewModel: appContainer.makeProfilePetsViewModel(),
                            profileOrdersViewModel: appContainer.makeProfileOrdersViewModel(),
                            
                            openSettings: {},
                            openPetAdding: {},
                            opentPetProfile: { id in
                                profileRouter.push(.petProfile(id: id))
                            },
                        )
                    case .settings:
                        SettingsScreen(
                            viewModel: appContainer.makeSettingsViewModel(),
                            
                            openSettingsAppearance: { profileRouter.push(.settingsAppearance) },
                            openSettingsPrivacy: { profileRouter.push(.settingsPrivacy) },
                            openSettingsNotifications: { profileRouter.push(.settingsNotifications) }
                        )
                    case .settingsAppearance:
                        SettingsAppearensScreen()
                    case .settingsPrivacy:
                        SettingsPrivacyScreen()
                    case .settingsNotifications:
                        SettingsNotificationsScreen()
                    case .petSettings(let id):
                        PetSettingsScreen(
                            viewModel: appContainer.makePetSettingsViewModel(
                                petId: id,
                                ownerUUID: ownerUUID
                            ),
                            petId: id,
                            ownerUUID: ownerUUID,
                            openPetProfile: openPetProfile
                        )
                    case .petProfile(let id):
                        PetProfileScreen(
                            viewModel: appContainer.makePetProfileViewModel(petId: id),
                            
                            petId: id,
                            openSettings: { id in
                                profileRouter.push(.petSettings(id: id))
                            }
                        )
                    case .petAdding:
                        PetAddingScreen(viewModel: appContainer.makePetAddingViewModel())
                    }
                }
        }
        .environment(profileRouter)
        .onOpenURL { url in
            print("📥 onOpenURL:", url.absoluteString)
            
            guard let deepLink = DeepLinkManager.parse(url: url) else { return }
            
            switch deepLink {
            case .profile(let uuid):
                profileRouter.push(.profile(uuid: uuid))
            }
        }
    }
}
