import SwiftUI

struct AuthBottomBarView: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Text(isPresented ? "Есть аккаунт?" : "Нет аккаунта?")
                .font(.system(.caption, design: .rounded))
                .foregroundColor(.secondary)
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPresented.toggle()
                }
            }) {
                Text(isPresented ? "Войти" : "Зарегистрироваться")
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(primaryColorService.currentColor.color)
                    .underline()
            }
        }
    }
}
