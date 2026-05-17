import SwiftUI

@main
struct dobyApp: App {
    @State private var container = AppContainer()
    @State private var themeService = ThemeService()
    @State private var primaryColorService = PrimaryColorService()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .appEnvironment(
                    container: container,
                    themeService: themeService,
                    primaryColorService: primaryColorService
                )
        }
    }
}
