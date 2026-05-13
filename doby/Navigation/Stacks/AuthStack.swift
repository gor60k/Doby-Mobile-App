import SwiftUI

struct AuthStack: View {
    @Environment(\.appContainer) private var appContainer
    
    @State private var router = AuthRouter()
    
    private var repository: AuthRepositoryProtocol { appContainer.repositories.authRepository }
    private var sessionService: SessionService { appContainer.services.sessionService }
    
    var body: some View {
        NavigationStack(path: $router.path) {
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
        .environment(router)
    }
}
