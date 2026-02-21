import SwiftUI

@main
struct dobyApp: App {
    @StateObject private var router = AppRouter()
    @State private var userVM = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if userVM.isAuthenticated {
                    NavigationStack {
                        RootTabView()
                            .navigationDestination(for: AppRoute.self) { route in
                                    destinationView(for: route)
                            }
                    }
                } else {
                    NavigationStack {
                        WelcomeView()
                            .navigationDestination(for: AppRoute.self) { route in
                                    destinationView(for: route)
                            }
                    }
                }
            }
            .environmentObject(router)
            .environment(userVM)
        }
    }
}

@ViewBuilder
private func destinationView(for route: AppRoute) -> some View {
    switch route {
    case .welcome: WelcomeView()
    case .role: RoleView()
    case .rootTab: RootTabView()
    }
}
