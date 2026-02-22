import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .glassEffect(
                .regular
                    .tint(isEnabled ? Color("PrimaryYellow") : Color.secondary)
                    .interactive(),
            )
            .animation(.easeInOut(duration: 0.3), value: isEnabled)
            .foregroundColor(.white)
    }
}

