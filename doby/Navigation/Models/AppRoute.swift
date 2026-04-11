import SwiftUI

enum AppRoute: Hashable {
    case welcome
    case auth
    case rootTab
    case profile(ProfileRoute)
    case settings(SettingsRoute)
    case pet(PetRoute)
}
