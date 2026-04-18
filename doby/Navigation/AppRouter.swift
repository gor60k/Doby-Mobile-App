import SwiftUI
import Combine

final class AppRouter: ObservableObject {
    enum StartDestination {
        case welcome
        case auth
        case rootTab
    }

    @Published var startDestination: StartDestination = .welcome
    @Published var selectedTab: RootTab = .profile

    func setInitialStartDestination(for session: SessionService) {
        startDestination = startDestination(for: session)
    }

    func goToWelcome() {
        withAnimation(.easeInOut(duration: 0.3)) {
            startDestination = .welcome
        }
    }

    func goToAuth() {
        withAnimation(.easeInOut(duration: 0.3)) {
            startDestination = .auth
        }
    }

    func goToRootTab() {
        withAnimation(.easeInOut(duration: 0.3)) {
            startDestination = .rootTab
        }
    }

    func refreshStartDestination(for session: SessionService) {
        withAnimation(.easeInOut(duration: 0.3)) {
            startDestination = startDestination(for: session)
        }
    }

    func startDestination(for session: SessionService) -> StartDestination {
        if !session.isRegistered {
            return .welcome
        }

        return session.isAuthenticated ? .rootTab : .auth
    }
}
