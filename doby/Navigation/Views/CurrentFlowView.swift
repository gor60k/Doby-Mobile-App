import SwiftUI

struct CurrentFlowView: View {
    @Environment(\.appContainer) private var appContainer
    
    private var sessionService: SessionService { appContainer.services.sessionService }

    var body: some View {
        ZStack {
            if !sessionService.isRegistered {
                WelcomeStack()
                    .transition(.opacity)
            } else if !sessionService.isAuthenticated {
                AuthStack()
                    .transition(.opacity)
            } else {
                RootTabStack()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: sessionService.isAuthenticated)
    }
}
