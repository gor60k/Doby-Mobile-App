import SwiftUI

typealias DefaultAppContainer = AppContainer<UserStorage, PetStorage>

@main
struct dobyApp: App {
    @State private var container: DefaultAppContainer = .init(
        userStorage: UserStorage(),
        petStorage: PetStorage()
    )
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
