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
    
    var body: some View {
        NavigationStack(path: $petRouter.path) {
            PetScreen(
                viewModel: appContainer.makePetViewModel(ownerUUID: ownerUUID),
                ownerUUID: userStorage.user?.uuid ?? "",
                openPetAdding: { petRouter.push(.petAdding) },
                openPetProfile: { id in
                    petRouter.push(.profile(id: id)) }
            )
                .navigationDestination(for: PetRoute.self) { route in
                    switch route {
                    case .petAdding:
                        PetAddingScreen(viewModel: appContainer.makePetAddingViewModel())
                    case .profile(let id):
                        PetProfileScreen(
                            viewModel: appContainer.makePetProfileViewModel(petId: id),
                            petId: id,
                            openSettings: { id in
                                petRouter.push(.petSettings(id: id))
                            }
                        )
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
                    }
                }
        }
        .environment(petRouter)
    }
}
