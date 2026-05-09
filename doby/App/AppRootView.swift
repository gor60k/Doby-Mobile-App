import SwiftUI

struct AppRootView: View {
    @Environment(AppRouter.self) private var appRouter
    @Environment(SessionService.self) private var sessionService
    
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
        .animation(shouldAnimateRootTransitions ? .easeInOut(duration: 0.3) : nil, value: appRouter.startDestination)
        .task {
            print("Start logic: \(Date())")
            appRouter.setInitialStartDestination(for: sessionService)
            print("End logic: \(Date())")
        }
    }
}
