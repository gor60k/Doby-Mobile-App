import SwiftUI

struct PetStack: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(\.userStorage) private var userStorage
    
    private var repository: PetRepositoryProtocol { appContainer.repositories.petRepository }
    
//    @State private var userStorage = UserStorage()
    @State private var petRouter = PetRouter()
    
    var body: some View {
        NavigationStack(path: $petRouter.path) {
            PetView(
                repository: repository,
                ownerUUID: userStorage.currentUser?.uuid ?? ""
            )
                .navigationDestination(for: PetRoute.self) { route in
                    switch route {
                    case .petAdding:
                        PetAddingView(repository: repository)
                    case .profile(let id):
                        PetProfileView(
                            repository: repository,
                            userStorage: userStorage,
                            petId: id
                        )
                    }
                }
        }
        .environment(petRouter)
    }
}
