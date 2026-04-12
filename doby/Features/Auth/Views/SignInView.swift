import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    private var session = SessionService.shared
    
    @State private var viewModel = AuthViewModel()
    @State private var didEditEmail = false
    @State private var didEditPassword = false
    @State private var didEditConfirmPassword = false
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(spacing: 16) {
            PrimaryTextField(title: "Введите ваш Email") {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            PrimaryTextField(
                title: "Введите пароль",
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
            
            PrimaryButton(title: "Войти", isEnabled: true, action: {
                Task {
                    await viewModel.login()
                    
                    if viewModel.errorMessage == nil {
                        await MainActor.run {
                            router.refreshStartDestination(for: session)
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
//                    viewModel.handleAppleRequest(request)
                },
                onCompletion: { result in
                    Task {
//                        await viewModel.handleAppleCompletion(result)
                        
                        if viewModel.errorMessage == nil {
                            await MainActor.run {
                                router.refreshStartDestination(for: session)
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
                action: {},
                buttonColor: Color("TelegramBlue")
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    SignInView()
}
