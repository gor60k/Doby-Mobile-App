import SwiftUI

@main
struct dobyApp: App {
    @StateObject private var router = AppRouter()
    private let session = SessionService.shared
    
    @StateObject private var themeService = ThemeService()
    @StateObject private var primaryColorService = PrimaryColorService()
    
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
                    switch route {
                    case .welcome: WelcomeView()
                    case .auth: AuthView()
                    case .rootTab: RootTabView()
                    case .settings: SettingsView()
                    case .settingsChild(let childRoute):
                        switch childRoute {
                        case .appearance: SettingsAppearensView()
                        case .privacy: SettingsPrivacyView()
                        case .notifications: SettingsNotificationsView()
                        }
                    }
                }
            }
            .environmentObject(router)
            .environmentObject(themeService)
            .environmentObject(primaryColorService)
            .environment(session)
            .preferredColorScheme(themeService.colorScheme)
        }
    }
}
