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
                .environment(container.infrastructure.sessionService)
                .environment(container.infrastructure.userStorage)
                .environment(container.infrastructure.petStorage)
                .environment(container)
                .environment(container.auth)
                .environment(container.pet)
                .environment(container.user)
                .environment(appRouter)
                .environment(themeService)
                .environment(primaryColorService)
                .preferredColorScheme(themeService.colorScheme)
        }
    }
}
