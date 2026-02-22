import SwiftUI

struct RootTabView: View {
    @State private var selectedTab: RootTab = .profile
    @Environment(AppSession.self) var session
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            if let role = session.currentUser?.role {
                switch role {
                case .owner: ownerTabs
                case .sitter: sitterTabs
                }
            }
            
            ChatView()
                .tabItem { Label(RootTab.chat.title, systemImage: RootTab.chat.icon) }
            
            ProfileView()
                .tabItem { Label(RootTab.profile.title, systemImage: RootTab.profile.icon) }
        }
        .tint(.primaryYellow)
    }
    
    @ViewBuilder
    var ownerTabs: some View {
        PetView()
            .tabItem { Label(RootTab.pet.title, systemImage: RootTab.pet.icon) }
        
        SearchView()
            .tabItem { Label(RootTab.search.title, systemImage: RootTab.search.icon) }
    }
    
    @ViewBuilder
    var sitterTabs: some View {
        CalendarView()
            .tabItem { Label(RootTab.calendar.title, systemImage: RootTab.calendar.icon) }
        
        EarningsView()
            .tabItem { Label(RootTab.earnings.title, systemImage: RootTab.earnings.icon) }
        
        OrdersView()
            .tabItem { Label(RootTab.orders.title, systemImage: RootTab.orders.icon) }
    }
}

#Preview {
    RootTabView()
        .environment(UserViewModel())
}
