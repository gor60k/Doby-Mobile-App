import SwiftUI

//typealias DefaultAppContainer = AppContainer<UserStorage, PetStorage, CityStorage>

@main
struct dobyApp: App {
//    @State private var container: DefaultAppContainer = .init(
//        userStorage: UserStorage(),
//        petStorage: PetStorage(),
//        cityStorage: CityStorage()
//    )
    
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
