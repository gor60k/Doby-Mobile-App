import SwiftUI
import Observation

@Observable
final class PrimaryColorService {
    var primaryColor: AppPrimaryColor {
        didSet {
            UserDefaults.standard.set(primaryColor.rawValue, forKey: "primaryColor")
        }
    }
    
    init() {
        let saved = UserDefaults.standard.string(forKey: "primaryColor")
        self.primaryColor = AppPrimaryColor(rawValue: saved ?? "") ?? .yellow
    }
    
    func setPrimaryColor(_ newColor: AppPrimaryColor) {
        guard primaryColor != newColor else { return }
        primaryColor = newColor
    }
}
