import SwiftUI

struct RootTabView: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    @EnvironmentObject private var appRouter: AppRouter
    
    private let session = SessionService.shared
    
    var body: some View {
        TabView(selection: $appRouter.selectedTab) {
            PetView()
                .tabItem { Label(RootTab.pet.title, systemImage: RootTab.pet.icon) }
                .tag(RootTab.pet)
            
            OrdersView()
                .tabItem { Label(RootTab.orders.title, systemImage: RootTab.orders.icon) }
                .tag(RootTab.orders)
            
            ChatView()
                .tabItem { Label(RootTab.chat.title, systemImage: RootTab.chat.icon) }
                .tag(RootTab.chat)
            
            ProfileView()
                .tabItem { Label(RootTab.profile.title, systemImage: RootTab.profile.icon) }
                .tag(RootTab.profile)
        }
        .tint(primaryColorService.currentColor.color)
    }
}

#Preview {
    RootTabView()
        .withAppEnvironment()
}
