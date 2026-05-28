import SwiftUI

struct AuthBottomBarView: View {
    @Environment(PrimaryColorService.self) var primaryColorService
    
    let openSignUp: () -> Void
    
    var body: some View {
        HStack {
            Text("Нет аккаунта?")
                .font(.system(.caption, design: .rounded))
                .foregroundColor(.secondary)
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    openSignUp()
                }
            }) {
                Text("Зарегистрироваться")
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(primaryColorService.primaryColor.color)
                    .underline()
            }
        }
    }
}
