import SwiftUI

struct AppContainerKey: EnvironmentKey {
    static let defaultValue: AppContainer = .init()
}

extension EnvironmentValues {
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}
