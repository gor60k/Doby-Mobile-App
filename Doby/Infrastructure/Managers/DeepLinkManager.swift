import SwiftUI

final class DeepLinkManager {
    static func parse(url: URL) -> DeepLink? {

        print("🔗 DeepLinkManager.parse")
        print("url =", url.absoluteString)
        print("scheme =", url.scheme ?? "nil")
        print("host =", url.host ?? "nil")
        print("path =", url.path)
        print("pathComponents =", url.pathComponents)

        guard url.scheme == "dobydog" else {
            print("❌ wrong scheme")
            return nil
        }

        let host = url.host
        let components = url.pathComponents

        switch host {
        case "profile":
            guard components.count >= 2 else {
                print("❌ profile uuid missing")
                return nil
            }

            let uuid = components[1]
            print("✅ profile deeplink:", uuid)

            return .profile(uuid)

        default:
            print("❌ unknown host:", host ?? "nil")
            return nil
        }
    }
}
