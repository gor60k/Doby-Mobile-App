import SwiftUI

struct AppRootView: View {
    @Environment(\.appContainer) private var appContainer
    @Environment(AppRouter.self) private var appRouter
    
    @State private var hasResolvedInitialRoute = false
    @State private var shouldAnimateRootTransitions = false
    
    var body: some View {
        ZStack {
            if let _ = appRouter.startDestination {
                CurrentFlowView()
            } else {
                ProgressView()
                    .transition(.opacity)
            }
        }
        .task {
            appRouter.setInitialStartDestination(for: appContainer.services.sessionService)
        }
    }
}
