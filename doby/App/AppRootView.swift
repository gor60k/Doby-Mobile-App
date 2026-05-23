import SwiftUI

struct AppRootView: View {
    @Environment(\.appContainer) private var appContainer
    
    var body: some View {
        CurrentFlowView()
    }
}
