import SwiftUI

struct AppContainerKey: EnvironmentKey {
    static let defaultValue: AppContainer = {
        do {
            return try AppContainer()
        } catch {
            fatalError("Ошибка при создании контейнера: \(error.localizedDescription)")
        }
    }()
}

extension EnvironmentValues {
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}
