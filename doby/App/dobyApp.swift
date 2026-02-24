import SwiftUI

@main
struct dobyApp: App {
    @StateObject private var router = AppRouter()
    @State private var session = SessionService()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if session.isRegistered {
                    NavigationStack(path: $router.path) {
                        RootTabView()
                            .navigationDestination(for: AppRoute.self) { route in
                                    destinationView(for: route)
                            }
                    }
                } else {
                    NavigationStack(path: $router.path) {
                        WelcomeView()
                            .navigationDestination(for: AppRoute.self) { route in
                                    destinationView(for: route)
                            }
                    }
                }
            }
            .environmentObject(router)
            .environment(session)
        }
    }
}

@ViewBuilder
private func destinationView(for route: AppRoute) -> some View {
    switch route {
    case .welcome: WelcomeView()
    case .role: RoleView()
    case .auth: AuthView()
    case .rootTab: RootTabView()
    }
}
