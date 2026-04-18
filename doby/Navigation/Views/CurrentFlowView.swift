import SwiftUI

struct CurrentFlowView: View {
    @EnvironmentObject private var router: AppRouter
    
    var body: some View {
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
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
        }
    }
}
