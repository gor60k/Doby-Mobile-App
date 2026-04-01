import SwiftUI

enum AppRoute: Hashable {
    case welcome
    case auth
    case rootTab
    case settings
    case settingsChild(SettingsRoute)
}
