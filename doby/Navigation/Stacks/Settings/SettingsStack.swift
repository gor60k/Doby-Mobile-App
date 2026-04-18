import SwiftUI

struct SettingsStack: View {
    @StateObject private var router = SettingsRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SettingsView()
                .navigationDestination(for: SettingsRoute.self) { route in
                    switch route {
                    case .appearance:
                        SettingsAppearensView()
                    case .privacy:
                        SettingsPrivacyView()
                    case .notifications:
                        SettingsNotificationsView()
                    case .petSettings:
                        PetSettingsView()
                    }
                }
        }
        .environmentObject(router)
    }
}
