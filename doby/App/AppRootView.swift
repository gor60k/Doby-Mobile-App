import SwiftUI

struct AppRootView: View {
    @EnvironmentObject private var appRouter: AppRouter
    
    let session: SessionService
    
    var body: some View {
        currentFlowView
            .onAppear {
                appRouter.refreshStartDestination(for: session)
            }
    }
    
    @ViewBuilder
    private var currentFlowView: some View {
        switch appRouter.startDestination {
        case .welcome:
            welcomeStack
        case .auth:
            authStack
        case .rootTab:
            rootTabStack
        }
    }
    
    private var welcomeStack: some View {
        WelcomeView()
    }
    
    private var authStack: some View {
        AuthView()
    }
    
    private var rootTabStack: some View {
        RootTabView()
    }
}
