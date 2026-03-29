import SwiftUI

struct SignUpView: View {
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
            
            PrimaryTextField(title: "Придумайте пароль") {
                TextField("Пароль", text: $viewModel.password)
            }
            
            PrimaryTextField(title: "Повторите пароль") {
                TextField("Пароль", text: $viewModel.password)
            }
            
            PrimaryButton(title: "Зарегистрироваться", isEnabled: true, action: {
                Task {
                    await viewModel.register()
                    
                    if viewModel.errorMessage == nil {
                        await MainActor.run {
                            router.popToRoot()
                        }
                    }
                }
            })
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    SignUpView()
}
