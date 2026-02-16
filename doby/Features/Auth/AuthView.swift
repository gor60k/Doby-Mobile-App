import SwiftUI

struct AuthView<Content: View>: View {
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            HeaderView(
                title: "Регистрация",
                subtitle: "Создайте свой свой аккаунт",
                titleStyle: AppTextStyles.largeTitleBold,
                subtitleStyle: AppTextStyles.headlineMedium
            )
            
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
    }
}

#Preview {
    AuthView(content: {
        VStack {
            Text("text")
        }
    })
}
