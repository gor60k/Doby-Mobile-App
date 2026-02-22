import SwiftUI

extension Text {
    func style(_ style: AppTextStyle) -> some View {
        self
            .font(style.font)
            .foregroundColor(style.color)
    }
}
