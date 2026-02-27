import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var router: AppRouter
    private var session = SessionService.shared
    
    @State private var viewModel = AuthViewModel()
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            PrimaryTextField(title: "Введите ваш Email") {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            PrimaryTextField(title: "Придумайте пароль") {
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
        }
        .padding(.horizontal)
    }
}
