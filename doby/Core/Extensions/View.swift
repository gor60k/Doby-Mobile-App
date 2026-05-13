import SwiftUI

extension View {
    @MainActor
    func appEnvironment(
        container: AppContainer,
        appRouter: AppRouter,
        themeService: ThemeService,
        primaryColorService: PrimaryColorService
    ) -> some View {
        self
            .environment(\.appContainer, container)
        
            .environment(\.userStorage, container.storage.user)
            .environment(\.petStorage, container.storage.pet)
        
            .environment(appRouter)
            .environment(themeService)
            .environment(primaryColorService)
        
            .preferredColorScheme(themeService.colorScheme)
    }
}
