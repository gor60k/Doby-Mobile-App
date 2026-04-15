import SwiftUI

struct AppRootView: View {
    @EnvironmentObject private var appRouter: AppRouter
    
    let session: SessionService
    
    var body: some View {
        NavigationStack(path: $appRouter.path) {
            rootView
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .welcome:
                        WelcomeView()
                    case .auth:
                        AuthView()
                    case .rootTab:
                        RootTabView()
                    case .profile(let route):
                        ProfileDestinationView(route: route)
                    case .settings(let route):
                        SettingsDestinationView(route: route)
                    case .pet(let route):
                        PetDestinationView(route: route)
                    case .petSettings:
                        PetSettingsView()
                    case .petAdding:
                        PetAddingView()
                    }
                }
        }
        .onAppear {
            appRouter.refreshStartDestination(for: session)
        }
    }
    
    @ViewBuilder
    private var rootView: some View {
        switch appRouter.startDestination {
        case .welcome:
            WelcomeView()
        case .auth:
            AuthView()
        case .rootTab:
            RootTabView()
        }
    }
}
