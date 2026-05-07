import SwiftUI
import Foundation
import Combine
import Observation

@Observable
final class SettingsRouter {
    var path = NavigationPath()
    
    func push(_ route: SettingsRoute) {
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
