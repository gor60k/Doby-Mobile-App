import SwiftUI

struct AuthStack: View {
    @Environment(\.appContainer) private var appContainer
    
    @State private var authRouter = AuthRouter()
    
    var body: some View {
        NavigationStack(path: $authRouter.path) {
            SignInScreen(viewModel: appContainer.makeAuthViewModel())
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .signUp:
                        SignUpScreen(viewMode: appContainer.makeAuthViewModel())
                    }
                }
        }
        .environment(authRouter)
    }
}
