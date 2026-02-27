import SwiftUI

@main
struct dobyApp: App {
    @StateObject private var router = AppRouter()
    private let session = SessionService.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                Group {
                    if session.isRegistered {
                        if session.isAuthenticated {
                            RootTabView()
                        } else {
                            AuthView()
                        }
                    } else {
                        WelcomeView()
                    }
                }
                .navigationDestination(for: AppRoute.self) { route in
                    destinationView(for: route)
                }
            }
            .environmentObject(router)
            .environment(session)
        }
    }
}
