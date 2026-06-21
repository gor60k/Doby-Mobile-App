import SwiftUI

struct ChatStack: View {
    @Environment(\.appContainer) private var appContainer
    
    @State private var chatRouter = ChatRouter()
    
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
                            viewModel: appContainer.makeProfileViewModel(),
                            profilePetsViewModel: appContainer.makeProfilePetsViewModel(),
                            profileOrdersViewModel: appContainer.makeProfileOrdersViewModel(),
                            openSettings: {},
                            openPetAdding: {},
                            opentPetProfile: { _ in }
                        )
                        .environment(DisplayModeService(mode: .visitor(userUUID: uuid)))
                    }
                }
        }
        .environment(chatRouter)
        
    }
}
