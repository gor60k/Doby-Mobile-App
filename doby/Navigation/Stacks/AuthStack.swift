import SwiftUI

struct AuthStack: View {
    @Environment(\.appContainer) private var appContainer
    
    @State private var authRouter = AuthRouter()
    
    private var repository: AuthRepositoryProtocol { appContainer.authRepository }
    private var sessionService: SessionService { appContainer.sessionService }
    
    var body: some View {
        NavigationStack(path: $authRouter.path) {
            SignInView(
                repository: repository,
                sessionService: sessionService
            )
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .signUp:
                        SignUpView(
                            repository: repository,
                            sessionSerive: sessionService
                        )
                    }
                }
        }
        .environment(authRouter)
    }
}
