import SwiftUI
import Combine

final class PrimaryColorService: ObservableObject {
    @AppStorage("primaryColor") private var storedColorRawValue: String = AppPrimaryColor.yellow.rawValue

    @Published var primaryColor: AppPrimaryColor {
        didSet {
            storedColorRawValue = primaryColor.rawValue
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

    var currentColor: AppPrimaryColor {
        primaryColor
    }
}
