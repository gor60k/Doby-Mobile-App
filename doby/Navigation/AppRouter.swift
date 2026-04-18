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

    func goToWelcome() {
        startDestination = .welcome
    }

    func goToAuth() {
        startDestination = .auth
    }

    func goToRootTab() {
        startDestination = .rootTab
    }

    func refreshStartDestination(for session: SessionService) {
        startDestination = startDestination(for: session)
    }

    func startDestination(for session: SessionService) -> StartDestination {
        if !session.isRegistered {
            return .welcome
        }

        return session.isAuthenticated ? .rootTab : .auth
    }
}
