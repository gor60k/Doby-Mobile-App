import SwiftUI

struct PrimaryButton: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    let title: String
    let isEnabled: Bool
    let action: () -> Void
    let buttonColor: Color?
    
    init(
        title: String,
        isEnabled: Bool = true,
        action: @escaping() -> Void,
        buttonColor: Color? = nil
    ) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
        self.buttonColor = buttonColor
    }
    
    private var resolvedColor: Color {
        buttonColor ?? primaryColorService.primaryColor.color
    }

    var body: some View {
        
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .glassEffect(
            .regular
                .tint(isEnabled ? resolvedColor : Color.secondary)
                .interactive(),
        )
        .animation(.easeInOut(duration: 0.3), value: isEnabled)
        .foregroundColor(.white)
        .disabled(!isEnabled)
    }
}

#Preview {
    PrimaryButton(
        title: "text",
        isEnabled: true,
        action: {},
    )
    .withAppEnvironment()
}
