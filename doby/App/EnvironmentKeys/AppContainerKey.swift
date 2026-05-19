import SwiftUI

struct AppContainerKey: EnvironmentKey {
    static let defaultValue: DefaultAppContainer = .init(
        userStorage: UserStorage(),
        petStorage: PetStorage(),
        cityStorage: CityStorage()
    )
}

extension EnvironmentValues {
    var appContainer: DefaultAppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}
