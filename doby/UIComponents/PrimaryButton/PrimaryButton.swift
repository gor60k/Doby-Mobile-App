import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void
    let buttonColor: Color?

    init(
        title: String,
        isEnabled: Bool = true,
        action: @escaping () -> Void = {},
        buttonColor: Color? = nil
    ) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
        self.buttonColor = buttonColor
    }

    var body: some View {
        Button {
            print("PRIMARY BUTTON TAP | title=\(title) | isEnabled=\(isEnabled)")
            action()
        } label: {
            Text(title)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .buttonStyle(PrimaryButtonStyle(
            isEnabled: isEnabled,
            buttonColor: buttonColor
        ))
        .disabled(!isEnabled)
    }
}

#Preview {
    PrimaryButton(title: "text")
}
