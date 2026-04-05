import SwiftUI
import Combine

final class PrimaryColorService: ObservableObject {
    @AppStorage("primaryColor") var storedColor: String = AppPrimaryColor.yellow.rawValue
    
    @Published var primaryColor: AppPrimaryColor = .yellow
    
    init() {
        primaryColor = AppPrimaryColor(rawValue: storedColor) ?? .yellow
    }
    
    func setPrimaryColor(_ newColor: AppPrimaryColor) {
        primaryColor = newColor
        storedColor = newColor.rawValue
    }
    
    var currentColor: AppPrimaryColor {
        primaryColor
    }
}
