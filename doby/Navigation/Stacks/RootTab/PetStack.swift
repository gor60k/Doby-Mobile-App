import SwiftUI

struct PetStack: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(UserStorage.self) private var userStorage
    @Environment(PetStorage.self) private var petStorage
    
    private var repository: PetRepositoryProtocol { appContainer.repositories.petRepository }
    
    @State private var petRouter = PetRouter()
    
    var body: some View {
        NavigationStack(path: $petRouter.path) {
            PetView(
                repository: repository,
                storage: petStorage,
                ownerUUID: userStorage.user?.uuid ?? ""
            )
                .navigationDestination(for: PetRoute.self) { route in
                    switch route {
                    case .petAdding:
                        PetAddingView(repository: repository)
                    case .profile(let id):
                        PetProfileView(
                            repository: repository,
                            userStorage: userStorage,
                            petStorage: petStorage,
                            petId: id
                        )
                    }
                }
        }
        .environment(petRouter)
    }
}
