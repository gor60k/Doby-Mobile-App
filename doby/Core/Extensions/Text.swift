import SwiftUI

extension Text {
    func style(_ style: TextStyle) -> some View {
        self
            .font(style.font)
            .foregroundColor(style.color)
    }
}
