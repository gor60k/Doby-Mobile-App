import SwiftUI

struct ChatScreen: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    @State private var searchText = ""
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<10, id: \.self) { _ in
                        ChatItemView(
                            userIcon: "MockUserIcon",
                            username: "user"
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
        ChatScreen()
    }
}
