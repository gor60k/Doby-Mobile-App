import SwiftUI

struct AppRootView: View {
    @EnvironmentObject private var appRouter: AppRouter
    
    let session: SessionService
    @State private var hasResolvedInitialRoute = false
    @State private var shouldAnimateRootTransitions = false
    
    var body: some View {
        ZStack {
            if hasResolvedInitialRoute {
                CurrentFlowView()
            } else {
                Color.clear
                    .ignoresSafeArea()
            }
        }
        .animation(shouldAnimateRootTransitions ? .easeInOut(duration: 0.3) : nil, value: appRouter.startDestination)
        .onAppear {
            guard !hasResolvedInitialRoute else { return }
            appRouter.setInitialStartDestination(for: session)
            hasResolvedInitialRoute = true
            DispatchQueue.main.async {
                shouldAnimateRootTransitions = true
            }
        }
    }
}
