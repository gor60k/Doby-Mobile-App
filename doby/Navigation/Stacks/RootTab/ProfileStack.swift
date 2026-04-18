import SwiftUI

struct ProfileStack: View {
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    @StateObject private var profileRouter = ProfileRouter()
    
    var body: some View {
        NavigationStack(path: $profileRouter.path) {
            ProfileView()
                .navigationDestination(for: ProfileRoute.self) { route in
                    switch route {
                    case .settings:
                        SettingsView()
                    case .settingsAppearance:
                        SettingsAppearensView()
                    case .settingsPrivacy:
                        SettingsPrivacyView()
                    case .settingsNotifications:
                        SettingsNotificationsView()
                    case .petSettings:
                        PetSettingsView()
                    case .petProfile(let id):
                        PetProfileView(petId: id)
                    }
                }
        }
        .environmentObject(profileRouter)
    }
}
