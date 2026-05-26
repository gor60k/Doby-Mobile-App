import SwiftUI

final class DeepLinkManager {
    static func parse(url: URL) -> DeepLink? {
        let components = url.pathComponents
        
        guard components.count == 3 else { return nil }
        
        switch components[1] {
        case "profile": return .profile(components[2])
        default: return nil
        }
    }
}
