import SwiftUI

@main
struct dobyApp: App {
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                WelcomeView()
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .welcome: WelcomeView()
                        case .role: RoleView()
                        case .home: HomeView()
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
