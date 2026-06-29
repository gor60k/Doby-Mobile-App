import SwiftUI

struct ProfileStack: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(UserStorage.self) private var userStorage
    
    @State private var profileRouter = ProfileRouter()
    @State private var petRouter = PetRouter()

    private var ownerUUID: String { userStorage.user?.uuid ?? "" }
    
    private func openPetProfile() {
        profileRouter.pop()
    }
    
    private func openURL(url: URL) {
        guard let deepLink = DeepLinkManager.parse(url: url) else { return }
        
        switch deepLink {
        case .profile(let uuid):
            profileRouter.push(.profile(uuid: uuid))
        }
    }
    
    // MARK: - структуры навигации
    private var profileNavigation: ProfileNavigation {
        ProfileNavigation(
            openSettings: { profileRouter.push(.settings) },
            openPetAdding: { profileRouter.push(.petAdding) },
            openPetProfile: { id in
                profileRouter.push(.petProfile(id: id))
            }
        )
    }
    
    private var settingsNavigation: SettingsNavigation {
        SettingsNavigation(
            openSettingsAppearance: { profileRouter.push(.settingsAppearance) },
            openSettingsPrivacy: { profileRouter.push(.settingsPrivacy) },
            openSettingsNotifications: { profileRouter.push(.settingsNotifications) }
        )
    }
    
    // MARK: - тело стака
    var body: some View {
        NavigationStack(path: $profileRouter.path) {
            createProfileScreen(target: .currentUser)
                .navigationDestination(for: ProfileRoute.self) { route in
                    switch route {
                    case .profile(let uuid):
                        createProfileScreen(target: .user(uuid: uuid ))
                    case .settings:
                        createSettingsScreen()
                    case .settingsAppearance:
                        SettingsAppearensScreen()
                    case .settingsPrivacy:
                        SettingsPrivacyScreen()
                    case .settingsNotifications:
                        SettingsNotificationsScreen()
                    case .petSettings(let id):
                        createPetSettingsScreen(petId: id)
                    case .petProfile(let id):
                        createPetProfileScreen(petId: id)
                    case .petAdding:
                        PetAddingScreen(viewModel: appContainer.makePetAddingViewModel())
                    }
                }
        }
        .environment(profileRouter)
        .onOpenURL { url in
            openURL(url: url)
        }
    }
}

// MARK: - фабрика экранов
extension ProfileStack {
    func createProfileScreen(target: ProfileTarget) -> ProfileScreen {
        ProfileScreen(
            viewModel: appContainer.makeProfileViewModel(with: target),
            profilePetsViewModel: appContainer.makeProfilePetsViewModel(),
            profileOrdersViewModel: appContainer.makeProfileOrdersViewModel(),
            
            profileNavigation: profileNavigation,
        )
    }
    
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
            openPetProfile: openPetProfile
        )
    }
    
    func createPetProfileScreen(petId: Int) -> PetProfileScreen {
        PetProfileScreen(
            viewModel: appContainer.makePetProfileViewModel(petId: petId),
            
            petId: petId,
            openSettings: { id in
                profileRouter.push(.petSettings(id: id))
            }
        )
    }
}
