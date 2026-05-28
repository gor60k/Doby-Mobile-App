import SwiftUI
import Observation

@Observable
class AppRouter<Route: Hashable> {
    var path = NavigationPath()
    
    func push(_ route: Route) {
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
}
