import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    private var session = SessionService.shared
    
    @State private var viewModel = AuthViewModel()
    @State private var didEditEmail = false
    @State private var didEditPassword = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                AuthHeaderView(
                    title: "C возвращением",
                    subtitle: "Войдите, чтобы продолжить пользоваться приложением"
                )
                
                VStack(spacing: 16) {
                    AuthEmailFieldView(
                        title: "Введите ваш Email",
                        isValid: viewModel.isEmailValid,
                        showsError: didEditEmail,
                        errorText: viewModel.isEmailValid ? "" : "Некоректный email",
                        email: $viewModel.email
                    )
                    .onChange(of: viewModel.email) { _, _ in
                        didEditEmail = true
                    }
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        AuthPasswordFieldView(
                            title: "Введите пароль",
                            placeholder: "Пароль не менее 8 символов",
                            isValid: viewModel.password.count >= 8,
                            showsError: didEditPassword,
                            errorText: viewModel.password.count >= 8 ? nil : "Минимум 8 символов",
                            password: $viewModel.password
                        )
                        .onChange(of: viewModel.password) { _, _ in
                            didEditPassword = true
                        }
                        
                        Button("Забыли пароль?") {
                            
                        }
                        .buttonStyle(.plain)
                        .foregroundColor(primaryColorService.currentColor.color)
                        .font(.system(.subheadline, design: .rounded))
                        .underline()
                    }
                    
                    
                    PrimaryButton(
                        title: "Войти",
                        isEnabled: viewModel.isLoginFormValid,
                        action: {
                            Task {
                                await viewModel.login()
                                
                                if viewModel.errorMessage == nil {
                                    await MainActor.run {
                                        router.refreshStartDestination(for: session)
                                        router.goToRootTab()
                                    }
                                }
                            }
                        }
                    )
                    
                    AuthBottomBarView()
                }
                .frame(maxWidth: .infinity)
                
                DividerLabel(label: "или")
                
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in
                    },
                    onCompletion: { result in
                        Task {
                            
                            if viewModel.errorMessage == nil {
                                await MainActor.run {
                                    router.refreshStartDestination(for: session)
                                    router.goToRootTab()
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
                    action: {},
                    buttonColor: Color("TelegramBlue")
                )
            }
            .padding(.horizontal)
        }
        .scrollDismissesKeyboard(.interactively)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SignInView()
        .withAppEnvironment()
}
