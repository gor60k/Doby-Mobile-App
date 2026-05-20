import SwiftUI

extension View {
    
    @MainActor
    func PreviewAppEnvironment() -> some View {
        appEnvironment(
            container: AppContainer(),
            themeService: ThemeService(),
            primaryColorService: PrimaryColorService()
        )
    }

    @MainActor
    func appEnvironment(
        container: AppContainer,
        themeService: ThemeService,
        primaryColorService: PrimaryColorService
    ) -> some View {
        self
            .environment(\.appContainer, container)
        
            .environment(container.petStorage)
            .environment(container.userStorage)
            .environment(container.cityStorage)
        
            .environment(themeService)
            .environment(primaryColorService)
        
            .preferredColorScheme(themeService.colorScheme)
    }
}
