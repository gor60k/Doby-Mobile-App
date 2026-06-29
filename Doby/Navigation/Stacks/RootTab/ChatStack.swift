import SwiftUI

struct ChatStack: View {
    @Environment(\.appContainer) private var appContainer
    
    @State private var chatRouter = ChatRouter()
    
    private var profileNavigation: ProfileNavigation {
        ProfileNavigation(
            openSettings: {},
            openPetAdding: {},
            openPetProfile: {_ in}
        )
    }
    
    var body: some View {
        NavigationStack(path: $chatRouter.path) {
            ChatScreen(
                openChatroom: { id in
                    chatRouter.push(.chatRoom(id: id))
                    print("OPEN CHAT ROOM")
                }
            )
                .navigationDestination(for: ChatRoute.self) { route in
                    switch route {
                    case .chatRoom(let id):
                        ChatRoomScreen()
                    case .profile(let uuid):
                        ProfileScreen(
                            viewModel: appContainer.makeProfileViewModel(
                                with: .user(uuid: uuid)
                            ),
                            profilePetsViewModel: appContainer.makeProfilePetsViewModel(),
                            profileOrdersViewModel: appContainer.makeProfileOrdersViewModel(),
                            profileNavigation: profileNavigation
                        )
                    }
                }
        }
        .environment(chatRouter)
        
    }
}
