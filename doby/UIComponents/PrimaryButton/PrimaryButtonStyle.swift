import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let buttonColor: Color?
    
    func makeBody(configuration: Configuration) -> some View {
        let color = buttonColor ?? .primaryYellow
        
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .glassEffect(
                .regular
                    .tint(isEnabled ? color : Color.secondary)
                    .interactive(),
            )
            .animation(.easeInOut(duration: 0.3), value: isEnabled)
            .foregroundColor(.white)
    }
}

