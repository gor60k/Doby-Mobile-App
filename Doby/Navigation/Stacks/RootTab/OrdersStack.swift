import SwiftUI

struct OrdersStack: View {
    @Environment(\.appContainer) private var appContainer
    
    @State private var ordersRouter = OrdersRouter()
    
    // MARK: - структуры навигации
    private var profileNavigation: ProfileNavigation {
        ProfileNavigation(
            openSettings: {},
            openPetAdding: {},
            openPetProfile: { _ in }
        )
    }
    
    // MARK: - тело стака
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
                        createProfileScreen(target: .user(uuid: uuid))
                    case .petProfile(let id):
                        createPetProfileScreen(petId: id)
                    case .chatRoom:
                        ChatRoomScreen()
                    }
                }
        }
    }
}

// MARK: - фабрика экранов
extension OrdersStack {
    func createProfileScreen(target: ProfileTarget) -> ProfileScreen {
        ProfileScreen(
            viewModel: appContainer.makeProfileViewModel(with: target),
            profilePetsViewModel: appContainer.makeProfilePetsViewModel(),
            profileOrdersViewModel: appContainer.makeProfileOrdersViewModel(),
            profileNavigation: profileNavigation
        )
    }
    
    func createPetProfileScreen(petId: Int) -> PetProfileScreen {
        PetProfileScreen(
            viewModel: appContainer.makePetProfileViewModel(petId: petId),
            petId: petId,
            openSettings: { id in }
        )
    }
}
