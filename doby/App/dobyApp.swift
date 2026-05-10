import SwiftUI

@main
struct dobyApp: App {
    @State private var container = AppContainer()
    @State private var appRouter = AppRouter()
    @State private var themeService = ThemeService()
    @State private var primaryColorService = PrimaryColorService()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .withAppEnvironment(
                    container: container,
                    appRouter: appRouter,
                    themeService: themeService,
                    primaryColorService: primaryColorService
                )
        }
    }
}
