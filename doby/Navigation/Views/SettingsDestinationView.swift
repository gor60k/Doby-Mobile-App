import SwiftUI

struct SettingsDestinationView: View {
    let route: SettingsRoute
    
    var body: some View {
        switch route {
        case .appearance:
            SettingsAppearensView()
        case .privacy:
            SettingsPrivacyView()
        case .notifications:
            SettingsNotificationsView()
        }
    }
}
