import SwiftUI

struct AuthView: View {
    @State private var session = SessionService()
    
    var body: some View {
        VStack {
            HeaderView(
                title: "Регистрация",
                subtitle: "Создайте аккаунт",
                titleStyle: AppTextStyle.Presets.largeTitleBold,
                subtitleStyle: AppTextStyle.Presets.subheadlineMedium
            )
            Divider()
                .overlay(.secondary)
                .padding(.horizontal)
            
            ScrollView {
                if session.selectedRole == .sitter {
                    SitterRegistrationView()
                } else {
                    OwnerRegistrationView(selectedRole: .owner)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
    }
}

#Preview {
    AuthView()
}
