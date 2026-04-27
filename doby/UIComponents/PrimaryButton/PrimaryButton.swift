import SwiftUI

struct PrimaryButton: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    let title: String
    let icon: String
    let isEnabled: Bool
    let action: () -> Void
    let buttonColor: Color?
    let size: PrimaryButtonSize
    
    init(
        title: String,
        icon: String = "",
        isEnabled: Bool = true,
        action: @escaping() -> Void,
        buttonColor: Color? = nil,
        size: PrimaryButtonSize = .large
    ) {
        self.title = title
        self.icon = icon
        self.isEnabled = isEnabled
        self.action = action
        self.buttonColor = buttonColor
        self.size = size
    }
    
    private var resolvedColor: Color {
        buttonColor ?? primaryColorService.primaryColor.color
    }

    var body: some View {
        
        Button {
            action()
        } label: {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .font(size.font)
            }
            
            Text(title)
                .font(size.font)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, size.verticalPadding)
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
        icon: "plus",
        action: {},
    )
    .withAppEnvironment()
}
