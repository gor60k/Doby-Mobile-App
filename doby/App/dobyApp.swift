import SwiftUI

@main
struct dobyApp: App {
    @StateObject private var appRouter = AppRouter()
    @StateObject private var themeService = ThemeService()
    @StateObject private var primaryColorService = PrimaryColorService()

    private let session = SessionService.shared

    var body: some Scene {
        WindowGroup {
            AppRootView(session: session)
                .environmentObject(appRouter)
                .environmentObject(themeService)
                .environmentObject(primaryColorService)
                .environment(session)
                .preferredColorScheme(themeService.colorScheme)
                .tint(primaryColorService.primaryColor.color)
        }
    }
}
