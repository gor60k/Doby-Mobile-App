import SwiftUI
import Combine

final class AppRouter: ObservableObject {
    enum StartDestination {
        case welcome
        case auth
        case rootTab
    }

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

    func reset(to route: AppRoute? = nil) {
        path = NavigationPath()

        if let route {
            switch route {
            case .welcome:
                break
            case .auth:
                break
            case .rootTab:
                break
            case .profile:
                break
            case .settings:
                break
            case .pet:
                break
            }

            path.append(route)
        }
    }

    func startDestination(for session: SessionService) -> StartDestination {
        if !session.isRegistered {
            return .welcome
        }
        
        return session.isAuthenticated ? .rootTab : .auth
    }
}
