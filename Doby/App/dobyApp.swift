import SwiftUI

@main
struct dobyApp: App {
    
    @State private var appContainer: AppContainer
    
    @State private var themeService = ThemeService()
    @State private var primaryColorService = PrimaryColorService()
    
    init() {
        do {
            appContainer = try AppContainer()
        } catch {
            fatalError("Ошибка при создании контейнера: \(error.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .appEnvironment(
                    container: appContainer,
                    themeService: themeService,
                    primaryColorService: primaryColorService,
//                    viewContextService: appContainer.viewContextService
                )
        }
    }
}
