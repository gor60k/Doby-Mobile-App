import SwiftUI

struct AppTextStyleViewModifier: ViewModifier {
    let style: AppTextStyle
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .foregroundColor(style.color)
    }
}
