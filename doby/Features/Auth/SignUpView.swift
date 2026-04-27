import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    private let session = SessionService.shared
    
    @State private var viewModel = AuthViewModel()
    @State private var didEditEmail = false
    @State private var didEditPassword = false
    @State private var didEditConfirmPassword = false
    
    private var isPasswordValid: Bool {
        viewModel.password.count >= 8
    }
    
    private var doPasswordsMatch: Bool {
        viewModel.password == viewModel.confirmPassword
    }
    
    private func register() {
        Task {
            await viewModel.register()
            
            if viewModel.errorMessage == nil {
                await MainActor.run {
                    router.refreshStartDestination(for: session)
                    router.goToRootTab()
                }
            }
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                AuthHeaderView(
                    title: "Добро пожаловать!",
                    subtitle: "Зарегистрируйтесь, чтобы продолжить пользоваться приложением"
                )
                
                
                VStack(spacing: 16) {
                    PrimaryTextField(
                        title: "Введите ваш Email",
                        isValid: viewModel.isEmailValid,
                        showsError: didEditEmail,
                        errorText: viewModel.isEmailValid ? nil : "Некорректный email"
                    ) {
                        TextField("Email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .onChange(of: viewModel.email) { _, _ in
                                didEditEmail = true
                            }
                    }
                    
                    AuthPasswordFieldView(
                        title: "Придумайте пароль",
                        placeholder: "Пароль не менее 8 символов",
                        isValid: isPasswordValid,
                        showsError: didEditPassword,
                        errorText: isPasswordValid ? nil : "Минимум 8 символов",
                        password: $viewModel.password
                    )
                    .onChange(of: viewModel.password) { _, _ in
                        didEditPassword = true
                    }
                    
                    AuthPasswordFieldView(
                        title: "Повторите пароль",
                        placeholder: "Пароль",
                        isValid: doPasswordsMatch,
                        showsError: didEditConfirmPassword,
                        errorText: doPasswordsMatch ? nil : "Пароли не совпадают",
                        password: $viewModel.confirmPassword
                    )
                    .onChange(of: viewModel.confirmPassword) { _, _ in
                        didEditConfirmPassword = true
                    }
                    
                    PrimaryButton(
                        title: "Зарегистрироваться",
                        isEnabled: viewModel.isRegisterFormValid,
                        action: register
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    SignUpView()
        .withAppEnvironment()
}
