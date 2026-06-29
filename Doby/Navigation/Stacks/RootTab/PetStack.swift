import SwiftUI

struct PetStack: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(UserStorage.self) private var userStorage
    @Environment(PetStorage.self) private var petStorage
    
    private var ownerUUID: String { userStorage.user?.uuid ?? "" }
    
    @State private var petRouter = PetRouter()
    
    private func openPetProfile() {
        petRouter.pop()
    }
    
    // MARK: - тело стака
    var body: some View {
        NavigationStack(path: $petRouter.path) {
            createPetScreen()
                .navigationDestination(for: PetRoute.self) { route in
                    switch route {
                    case .petAdding:
                        PetAddingScreen(viewModel: appContainer.makePetAddingViewModel())
                    case .profile(let id):
                        createPetProfileScreen(petId: id)
                    case .petSettings(let id):
                        createPetSettingsScreen(petId: id)
                    }
                }
        }
        .environment(petRouter)
    }
}

// MARK: - фабрика экранов
extension PetStack {
    func createPetScreen() -> PetScreen {
        PetScreen(
            viewModel: appContainer.makePetViewModel(ownerUUID: ownerUUID),
            ownerUUID: userStorage.user?.uuid ?? "",
            openPetAdding: { petRouter.push(.petAdding) },
            openPetProfile: { id in
                petRouter.push(.profile(id: id)) }
        )
    }
    
    func createPetProfileScreen(petId: Int) -> PetProfileScreen {
        PetProfileScreen(
            viewModel: appContainer.makePetProfileViewModel(petId: petId),
            petId: petId,
            openSettings: { id in
                petRouter.push(.petSettings(id: id))
            }
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
}
