import SwiftUI
import Combine

final class AppRouter: ObservableObject {
    enum StartDestination {
        case welcome
        case auth
        case rootTab
    }

    @Published var startDestination: StartDestination = .welcome

    @Published var path = NavigationPath()
    @Published var selectedTab: RootTab = .profile

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        guard !path.isEmpty else { return }
        path = NavigationPath()
    }

    func refreshStartDestination(for session: SessionService) {
        if !session.isRegistered {
            startDestination = .welcome
            return
        }

        startDestination = session.isAuthenticated ? .rootTab : .auth
    }

    func startDestination(for session: SessionService) -> StartDestination {
        if !session.isRegistered {
            return .welcome
        }

        return session.isAuthenticated ? .rootTab : .auth
    }
}
