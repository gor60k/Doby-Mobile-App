import SwiftUI

struct AppTextStyleViewModifier: ViewModifier {
    let style: TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .foregroundColor(style.color)
    }
}
