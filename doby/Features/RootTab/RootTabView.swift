import SwiftUI

struct RootTabView: View {
    @Environment(PrimaryColorService.self) var primaryColorService
    
    @State private var selectedTab: RootTab = .profile

    var body: some View {
        TabView(selection: $selectedTab) {
            PetStack()
                .tabItem { Label(RootTab.pet.title, systemImage: RootTab.pet.icon) }
                .tag(RootTab.pet)

            OrdersStack()
                .tabItem { Label(RootTab.orders.title, systemImage: RootTab.orders.icon) }
                .tag(RootTab.orders)

            ChatStack()
                .tabItem { Label(RootTab.chat.title, systemImage: RootTab.chat.icon) }
                .tag(RootTab.chat)

            ProfileStack()
                .tabItem { Label(RootTab.profile.title, systemImage: RootTab.profile.icon) }
                .tag(RootTab.profile)
        }
        .tint(primaryColorService.primaryColor.color)
    }
}
