import SwiftUI
import Foundation
import Combine
import Observation

@Observable
final class ProfileRouter {
    var path = NavigationPath()

    func push(_ route: ProfileRoute) {
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
