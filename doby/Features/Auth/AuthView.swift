import SwiftUI

struct AuthView<Content: View>: View {
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
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
                content
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
    }
}

#Preview {
    AuthView(content: {
        OwnerRegistrationView(selectedRole: "")
    })
}
