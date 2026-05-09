import SwiftUI
import Observation

@MainActor
@Observable
final class AppRouter {
    enum StartDestination {
        case welcome
        case auth
        case rootTab
    }

    var startDestination: StartDestination? = nil
    var selectedTab: RootTab = .profile

    func setInitialStartDestination(for session: SessionService) {
        let destination = startDestination(for: session)
        withAnimation(.easeInOut(duration: 0.3)) {
            self.startDestination = destination
        }
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
