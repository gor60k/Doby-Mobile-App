import SwiftUI

struct AuthStack: View {
    @Environment(\.appContainer) private var appContainer
    
    @State private var router = AuthRouter()
    
    private var repository: AuthRepositoryProtocol { appContainer.repositories.authRepository }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SignInView(repository: repository)
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .signUp:
                        SignUpView(repository: repository)
                    }
                }
        }
        .environment(router)
    }
}
