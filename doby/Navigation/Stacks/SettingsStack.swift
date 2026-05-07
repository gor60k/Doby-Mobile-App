import SwiftUI

struct SettingsStack: View {
    @Environment(AuthContainer.self) private var container
    
    @State private var router = SettingsRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SettingsView(repository: container.repository)
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
        .environment(router)
    }
}
