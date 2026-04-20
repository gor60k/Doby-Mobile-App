import SwiftUI

struct AuthBottomBarView: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    @EnvironmentObject var router: AuthRouter
    
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
                    .foregroundColor(primaryColorService.currentColor.color)
                    .underline()
            }
        }
    }
}
