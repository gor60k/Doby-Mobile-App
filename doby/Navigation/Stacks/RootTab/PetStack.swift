import SwiftUI

struct PetStack: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(UserStorage.self) private var userStorage
    @Environment(PetStorage.self) private var petStorage
    
    @State private var petRouter = PetRouter()
    
    var body: some View {
        NavigationStack(path: $petRouter.path) {
            PetView(
                viewModel: appContainer.makePetViewModel(),
                ownerUUID: userStorage.user?.uuid ?? "",
                openPetAdding: { petRouter.push(.petAdding) },
                openPetProfile: { id in
                    petRouter.push(.profile(id: id)) }
            )
                .navigationDestination(for: PetRoute.self) { route in
                    switch route {
                    case .petAdding:
                        PetAddingView(viewModel: appContainer.makePetAddingViewModel())
                    case .profile(let id):
                        PetProfileView(
                            viewModel: appContainer.makePetProfileViewModel(petId: id),
                            petId: id,
                            openSettings: { id in
                                petRouter.push(.petSettings(id: id))
                            }
                        )
                    case .petSettings(let id):
                        PetSettingsView()
                    }
                }
        }
        .environment(petRouter)
    }
}
