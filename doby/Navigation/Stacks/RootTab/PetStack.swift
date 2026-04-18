import SwiftUI

struct PetStack: View {
    @StateObject private var petRouter = PetRouter()
    
    var body: some View {
        NavigationStack(path: $petRouter.path) {
            PetView()
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
