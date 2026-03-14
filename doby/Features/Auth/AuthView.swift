import SwiftUI

struct AuthView: View {
    private let session = SessionService.shared
    
    var body: some View {
        VStack {
            ViewHeadline(
                title: "Регистрация",
                subtitle: "Создайте аккаунт",
                titleStyle: AppTextStyle.Presets.largeTitleBold,
                subtitleStyle: AppTextStyle.Presets.subheadlineMedium
            )
            Divider()
                .overlay(.secondary)
                .padding(.horizontal)
            
            ScrollView {
                if session.isRegistered {
                   SignInView()
                } else {
                    if session.selectedRole == .sitter {
                        SitterRegistrationView(selectedRole: .sitter)
                    } else {
                        OwnerRegistrationView(selectedRole: .owner)
                    }
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
