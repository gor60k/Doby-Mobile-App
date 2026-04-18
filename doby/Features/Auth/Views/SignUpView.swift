import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    private var session = SessionService.shared
    
    @State private var viewModel = AuthViewModel()
    @State private var didEditEmail = false
    @State private var didEditPassword = false
    @State private var didEditConfirmPassword = false
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Добро пожаловать!")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    
                    Text("Зарегистрируйтесь, чтобы продолжить пользоваться приложением")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
                
                
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
                    
                    PrimaryTextField(
                        title: "Придумайте пароль",
                        isValid: viewModel.password.count >= 8,
                        showsError: didEditPassword,
                        errorText: viewModel.password.count >= 8 ? nil : "Минимум 8 символов"
                    ) {
                        HStack(spacing: 8) {
                            Group {
                                if isPasswordVisible {
                                    TextField("Пароль не менее 8 символов", text: $viewModel.password)
                                } else {
                                    SecureField("Пароль не менее 8 символов", text: $viewModel.password)
                                }
                            }
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .textContentType(.newPassword)
                            .onChange(of: viewModel.password) { _, _ in
                                didEditPassword = true
                            }
                            
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .frame(height: 22)
                                    .foregroundColor(primaryColorService.currentColor.color)
                            }
                        }
                    }
                    
                    PrimaryTextField(
                        title: "Повторите пароль",
                        isValid: viewModel.password == viewModel.confirmPassword,
                        showsError: didEditConfirmPassword,
                        errorText: viewModel.password == viewModel.confirmPassword ? nil : "Пароли не совпадают"
                    ) {
                        HStack(spacing: 8) {
                            Group {
                                if isConfirmPasswordVisible {
                                    TextField("Пароль", text: $viewModel.confirmPassword)
                                } else {
                                    SecureField("Пароль", text: $viewModel.confirmPassword)
                                }
                            }
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .onChange(of: viewModel.confirmPassword) { _, _ in
                                didEditConfirmPassword = true
                            }
                            
                            Button {
                                isConfirmPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isConfirmPasswordVisible ? "eye.slash" : "eye")
                                    .frame(height: 22)
                                    .foregroundColor(primaryColorService.currentColor.color)
                            }
                        }
                    }
                    
                    PrimaryButton(
                        title: "Зарегистрироваться",
                        isEnabled: viewModel.isRegisterFormValid,
                        action: {
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
