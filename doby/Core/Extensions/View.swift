import SwiftUI

//extension View {
//
//    @MainActor
//    func withAppEnvironment(
//        container: AppContainer? = nil,
//        appRouter: AppRouter? = nil,
//        themeService: ThemeService? = nil,
//        primaryColorService: PrimaryColorService? = nil
//    ) -> some View {
//
//        let container = container ?? AppContainer()
//        let appRouter = appRouter ?? AppRouter()
//        let themeService = themeService ?? ThemeService()
//        let primaryColorService = primaryColorService ?? PrimaryColorService()
//
//        return self
//            .environment(container.infrastructure.sessionService)
//            .environment(container.infrastructure.userStorage)
//            .environment(container.infrastructure.petStorage)
//
//            .environment(container)
//            .environment(container.auth)
//            .environment(container.pet)
//            .environment(container.user)
//
//            .environment(appRouter)
//            .environment(themeService)
//            .environment(primaryColorService)
//
//            .preferredColorScheme(themeService.colorScheme)
//    }
//}

extension View {
    @MainActor
    func appEnvironment(
        container: NAppContainer,
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
