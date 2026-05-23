import SwiftUI

@main
struct dobyApp: App {
    
    @State private var appContainer = AppContainer()
    @State private var themeService = ThemeService()
    @State private var primaryColorService = PrimaryColorService()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .appEnvironment(
                    container: appContainer,
                    themeService: themeService,
                    primaryColorService: primaryColorService
                )
        }
    }
}
