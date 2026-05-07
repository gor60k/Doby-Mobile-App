import SwiftUI

struct AuthStack: View {
    @Environment(AuthContainer.self) private var container
    
    @State private var router = AuthRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SignInView(repository: container.repository)
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .signUp:
                        SignUpView(repository: container.repository)
                    }
                }
        }
        .environment(router)
    }
}
