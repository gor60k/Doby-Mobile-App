import SwiftUI

struct UtilityButton: View {
    let action: () -> Void
    let title: String?
    let icon: String?
    let tint: Color?
    
    init(
        action: @escaping () -> Void,
        title: String = "",
        icon: String = "",
        tint: Color? = nil
    ) {
        self.action = action
        self.title = title
        self.icon = icon
        self.tint = tint
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if title != "" {
                    Text(title ?? "")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.primary)
                }
                
                if icon != "" {
                    Image(systemName: icon ?? "")
                        .foregroundColor(.primary)
                }
            }
            .frame(alignment: .center)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .glassEffect(
            .regular
                .tint(tint ?? Color.clear)
                .interactive()
        )
    }
}

#Preview {
    UtilityButton(action: {}, icon: "plus")
}
