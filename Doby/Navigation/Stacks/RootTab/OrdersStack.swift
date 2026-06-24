import SwiftUI

struct OrdersStack: View {
    @Environment(\.appContainer) private var appContainer
    
    @State private var ordersRouter = OrdersRouter()
    
    var body: some View {
        NavigationStack(path: $ordersRouter.path) {
            OrdersScreen(
                openOrderTypes: { ordersRouter.push(.orderTypes) },
                openSitters: { ordersRouter.push(.sitters) }
            )
                .navigationDestination(for: OrdersRoute.self) { route in
                    switch route {
                    case .orderTypes: OrdersChooseScreen(
                        openSitters: { ordersRouter.push(.sitters) }
                    )
                    case .sitters: OrdersSitterScreen()
                    case .profile(let uuid):
                        ProfileScreen(
                            viewModel: appContainer.makeProfileViewModel(with: .user(uuid: uuid)),
                            profilePetsViewModel: appContainer.makeProfilePetsViewModel(),
                            profileOrdersViewModel: appContainer.makeProfileOrdersViewModel(),
                            openSettings: {},
                            openPetAdding: {},
                            opentPetProfile: { _ in }
                        )
                        .environment(DisplayModeService(mode: .visitor))
                    case .petProfile(let id):
                        PetProfileScreen(
                            viewModel: appContainer.makePetProfileViewModel(petId: id),
                            petId: id,
                            openSettings: { id in }
                        )
                    case .chatRoom(let id):
                        ChatRoomScreen()
                    }
                }
        }
    }
}
