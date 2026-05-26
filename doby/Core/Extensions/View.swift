import SwiftUI

extension View {
    
    @MainActor
    func PreviewAppEnvironment(
        displayModeService: DisplayModeService? = nil
    ) -> some View {
        appEnvironment(
            container: AppContainer(),
            themeService: ThemeService(),
            primaryColorService: PrimaryColorService(),
            displayModeService: displayModeService ?? DisplayModeService()
        )
    }

    @MainActor
    func appEnvironment(
        container: AppContainer,
        themeService: ThemeService,
        primaryColorService: PrimaryColorService,
        displayModeService: DisplayModeService
    ) -> some View {
        self
            .environment(\.appContainer, container)
        
            .environment(container.petStorage)
            .environment(container.userStorage)
            .environment(container.cityStorage)
        
            .environment(container.sessionService)
            .environment(displayModeService)
        
            .environment(themeService)
            .environment(primaryColorService)
        
            .preferredColorScheme(themeService.colorScheme)
    }
}
