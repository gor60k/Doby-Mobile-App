import SwiftUI

struct RootTabView: View {
    @State private var selectedTab: RootTab = .chat
    private let session = SessionService.shared
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PetView()
                .tabItem { Label(RootTab.pet.title, systemImage: RootTab.pet.icon) }
            
            OrdersView()
                .tabItem { Label(RootTab.orders.title, systemImage: RootTab.orders.icon) }
            
            ChatView()
                .tabItem { Label(RootTab.chat.title, systemImage: RootTab.chat.icon) }
            
            ProfileView()
                .tabItem { Label(RootTab.profile.title, systemImage: RootTab.profile.icon) }
        }
        .tint(.primaryYellow)
    }
}

#Preview {
    RootTabView()
}
