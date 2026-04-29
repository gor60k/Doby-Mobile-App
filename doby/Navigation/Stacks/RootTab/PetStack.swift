import SwiftUI

struct PetStack: View {
    @StateObject private var petRouter = PetRouter()
    @State private var repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    var body: some View {
        NavigationStack(path: $petRouter.path) {
            PetView(ownerUUID: repository.getCurrentUser()!.uuid)
                .navigationDestination(for: PetRoute.self) { route in
                    switch route {
                    case .petAdding:
                        PetAddingView()
                    case .profile(let id):
                        PetProfileView(petId: id)
                    }
                }
        }
        .environmentObject(petRouter)
    }
}
