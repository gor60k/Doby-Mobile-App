import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @EnvironmentObject private var router: AppRouter
    private var session = SessionService.shared
    
    @State private var viewModel = AuthViewModel()
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 16) {
            PrimaryTextField(title: "Введите ваш Email") {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            PrimaryTextField(title: "Введите пароль") {
                TextField("Пароль", text: $viewModel.password)
            }
            
            PrimaryButton(title: "Войти", isEnabled: true, action: {
                Task {
                    await viewModel.login()
                    
                    if viewModel.errorMessage == nil {
                        await MainActor.run {
                            router.popToRoot()
                        }
                    }
                }
            })
            
            Divider()
                .background(.secondary)
            
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in
                    viewModel.handleAppleRequest(request)
                },
                onCompletion: { result in
                    Task {
                        await viewModel.handleAppleCompletion(result)
                        
                        if viewModel.errorMessage == nil {
                            await MainActor.run {
                                router.popToRoot()
                            }
                        }
                    }
                }
            )
            .frame(height: 54)
            .signInWithAppleButtonStyle(.black)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
            PrimaryButton(
                title: "Войти с Telegram",
                isEnabled: true,
                action: nil,
                buttonColor: Color("TelegramBlue")
            )
            
//            HStack {
//                Text("Нет аккаунта?")
//                    .foregroundColor(.secondary)
//                NavigationLink(destination: SignUpView()) {
//                    Text("Зарегистрируйтесь!")
//                        .foregroundColor(Color("PrimaryYellow"))
//                        .underline()
//                }
//            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    SignInView()
}
