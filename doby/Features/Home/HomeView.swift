import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
            
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

