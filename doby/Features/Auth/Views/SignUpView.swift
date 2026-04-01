import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    private var session = SessionService.shared
    
    @State private var viewModel = AuthViewModel()
    @State private var didEditEmail = false
    @State private var didEditPassword = false
    @State private var didEditConfirmPassword = false
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    
    var body: some View {
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
                isValid: viewModel.password.count >= 6,
                showsError: didEditPassword,
                errorText: viewModel.password.count >= 6 ? nil : "Минимум 6 символов"
            ) {
                HStack(spacing: 8) {
                    Group {
                        if isPasswordVisible {
                            TextField("Пароль не менее 6 символов", text: $viewModel.password)
                        } else {
                            SecureField("Пароль не менее 6 символов", text: $viewModel.password)
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
                isEnabled: viewModel.isFormValid,
                action: {
                    Task {
                        await viewModel.register()
                        
                        if viewModel.errorMessage == nil {
                            await MainActor.run {
                                router.popToRoot()
                            }
                        }
                    }
                }
            )
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    SignUpView()
}
