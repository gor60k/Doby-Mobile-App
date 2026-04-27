import SwiftUI

struct AuthStack: View {
    @StateObject private var router = AuthRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SignInView()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .signUp:
                        SignUpView()
                    }
                }
        }
        .environmentObject(router)
    }
}
