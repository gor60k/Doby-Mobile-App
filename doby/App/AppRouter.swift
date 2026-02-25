import SwiftUI
import Combine

enum AppRoute: Hashable {
    case welcome
    case role
    case auth
    case login
    case rootTab
}

final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
