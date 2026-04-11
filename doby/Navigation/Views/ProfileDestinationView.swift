import SwiftUI

struct ProfileDestinationView: View {
    let route: ProfileRoute
    
    var body: some View {
        switch route {
        case .settings: SettingsView()
        }
    }
}
