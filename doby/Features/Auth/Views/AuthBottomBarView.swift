import SwiftUI

struct AuthBottomBarView: View {
    @Environment(PrimaryColorService.self) var primaryColorService
    @Environment(AuthRouter.self) var router
    
    var body: some View {
        HStack {
            Text("Нет аккаунта?")
                .font(.system(.caption, design: .rounded))
                .foregroundColor(.secondary)
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    router.push(.signUp)
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
