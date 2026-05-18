import SwiftUI

extension View {
    
    @MainActor
    func PreviewAppEnvironment() -> some View {
        appEnvironment(
            container: .init(
                userStorage: UserStorage(),
                petStorage: PetStorage()
            ),
            themeService: ThemeService(),
            primaryColorService: PrimaryColorService()
        )
    }

    @MainActor
    func appEnvironment(
        container: DefaultAppContainer,
        themeService: ThemeService,
        primaryColorService: PrimaryColorService
    ) -> some View {
        self
            .environment(\.appContainer, container)
        
            .environment(container.storage.pet)
            .environment(container.storage.user)
        
            .environment(themeService)
            .environment(primaryColorService)
        
            .preferredColorScheme(themeService.colorScheme)
    }
}
