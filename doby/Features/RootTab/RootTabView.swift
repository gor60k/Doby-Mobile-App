import SwiftUI

struct RootTabView: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    @EnvironmentObject private var appRouter: AppRouter

    @EnvironmentObject private var petRouter: PetRouter
    @EnvironmentObject private var profileRouter: ProfileRouter

    private let session = SessionService.shared

    var body: some View {
        TabView(selection: $appRouter.selectedTab) {
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
        .tint(primaryColorService.currentColor.color)
    }
}

#Preview {
    RootTabView()
        .withAppEnvironment()
}
