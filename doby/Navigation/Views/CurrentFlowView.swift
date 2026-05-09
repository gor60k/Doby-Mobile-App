import SwiftUI

struct CurrentFlowView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        Group {
            switch router.startDestination {
            case .welcome:
                WelcomeStack()
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
            case .auth:
                AuthStack()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .rootTab:
                RootTabStack()
            case nil:
                ProgressView()
            }
        }
    }
}
