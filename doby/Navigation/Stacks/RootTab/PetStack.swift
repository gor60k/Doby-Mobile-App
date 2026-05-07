import SwiftUI

struct PetStack: View {
    @Environment(PetContainer.self) private var container
    
    @State private var userStorage = UserStorage()
    @State private var petRouter = PetRouter()
    
    var body: some View {
        NavigationStack(path: $petRouter.path) {
            PetView(
                repository: container.repository,
                ownerUUID: userStorage.currentUser?.uuid ?? ""
            )
                .navigationDestination(for: PetRoute.self) { route in
                    switch route {
                    case .petAdding:
                        PetAddingView(repository: container.repository)
                    case .profile(let id):
                        PetProfileView(
                            repository: container.repository,
                            petId: id
                        )
                    }
                }
        }
        .environment(petRouter)
    }
}
