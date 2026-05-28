import SwiftUI

struct ChatScreen: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    @State private var searchText = ""
    @State private var selectedTab = 0
    
    private let openChatroom: (Int) -> Void
    
    init(openChatroom: @escaping (Int) -> Void) {
        self.openChatroom = openChatroom
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<10, id: \.self) { _ in
                        ChatItemView(
                            chatId: 1,
                            userIcon: "MockUserIcon",
                            username: "User",
                            lastMessage: "text",
                            lastMessageTime: "11:11",
                            openChatroom: openChatroom
                        )
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.automatic)
        }
        .navigationTitle("Чаты")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Изм.") {
                    
                }
                .tint(.primary)
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Поиск"
        )
    }
}

#Preview {
    NavigationStack {
        ChatScreen(
            openChatroom: { _ in }
        )
    }
    .PreviewAppEnvironment()
}
