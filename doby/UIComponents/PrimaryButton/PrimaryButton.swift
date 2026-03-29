import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isEnabled: Bool?
    let action: (() -> Void)?
    let buttonColor: Color?
    
    init(
        title: String,
        isEnabled: Bool? = true,
        action: (() -> Void)? = nil,
        buttonColor: Color? = nil
    ) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
        self.buttonColor = buttonColor
    }
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Text(title)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.medium)
        }
        .disabled(!(isEnabled ?? true))
        .buttonStyle(PrimaryButtonStyle(
            isEnabled: isEnabled ?? true,
            buttonColor: buttonColor
        ))
    }
}

#Preview {
    PrimaryButton(title: "text", isEnabled: nil, action: nil)
}
