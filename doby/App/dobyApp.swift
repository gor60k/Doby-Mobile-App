import SwiftUI

@main
struct dobyApp: App {
    @StateObject private var router = AppRouter()
    @State private var session = AppSession(user: nil, auth: false)
    
    var body: some Scene {
        WindowGroup {
            Group {
                if session.isAuthenticated {
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
