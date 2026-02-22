import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isEnabled: Bool?
    let action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Text(title)
                .font(.system(.headline))
        }
        .disabled(!(isEnabled ?? true))
        .buttonStyle(PrimaryButtonStyle(isEnabled: isEnabled ?? true))
    }
}

#Preview {
    PrimaryButton(title: "text", isEnabled: nil, action: nil)
}
