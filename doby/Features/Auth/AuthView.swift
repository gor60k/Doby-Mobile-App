import SwiftUI

struct AuthView: View {
    private let session = SessionService.shared
    
    @State private var isSignUp: Bool = false
    
    var body: some View {
        VStack {
            ViewHeadline(
                title: isSignUp ? "Регистрация" : "Войти",
                subtitle: isSignUp ? "Создайте новый аккаунт" : "Войдите в свой аккаунт",
                titleStyle: AppTextStyle.Presets.largeTitleBold,
                subtitleStyle: AppTextStyle.Presets.headlineRegular
            )
            Divider()
                .overlay(.secondary)
                .padding(.horizontal)
            
            ScrollView {
                ZStack(alignment: .topLeading) {
                    if isSignUp {
                        SignUpView()
                            .frame(maxHeight: .infinity, alignment: .top)
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            ))
                    } else {
                        SignInView()
                            .frame(maxHeight: .infinity, alignment: .top)
                            .transition(.asymmetric(
                                insertion: .move(edge: .leading),
                                removal: .move(edge: .trailing)
                            ))
                    }
                }
                .frame(height: 450)
                .clipped()
            }
            
            Spacer()
            
            HStack {
                Text(isSignUp ? "Есть аккаунт?" : "Нет аккаунта?")
                    .foregroundColor(.secondary)
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isSignUp.toggle()
                    }
                }) {
                    Text(isSignUp ? "Войти" : "Зарегистрироваться")
                        .foregroundColor(.primaryYellow)
                        .underline()
                }
            }
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
        .background(.primaryBackground)
    }
}

#Preview {
    AuthView()
}
