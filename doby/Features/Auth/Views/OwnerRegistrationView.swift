import SwiftUI
import PhoneNumberKit

struct OwnerRegistrationView: View {
    @EnvironmentObject private var router: AppRouter
    private let session = SessionService.shared
    
    @State private var viewModel = AuthViewModel()
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""
    @State private var city: City? = nil
    
    let selectedRole: Role
    
    var body: some View {
            VStack(spacing: 16) {
                PrimaryTextField(title: "Введите имя") {
                    TextField("Имя", text: $viewModel.name)
                }
                
                PrimaryTextField(title: "Введите ваш Email") {
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
                
                PrimaryTextField(title: "Введите номер телефона") {
                    TextField("Phone", text: $viewModel.phone)
                        .keyboardType(.phonePad)
                }
                
                CityAutocompleteView(selectedCity: Binding(
                    get: { viewModel.city ?? City(name: "", translit: "") },
                    set: { viewModel.city = $0 }
                ))
                
                PrimaryTextField(title: "Придумайте пароль") {
                    TextField("Пароль", text: $viewModel.password)
                }
                
                PrimaryButton(
                    title: "Зарегистрироваться",
                    isEnabled: !viewModel.name.isEmpty && !viewModel.isLoading,
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
                
                Divider()
                    .overlay(.secondary)
                
                PrimaryButton(
                    title: "Войти с Google",
                    isEnabled: true,
                    action: nil
                )
                
                PrimaryButton(
                    title: "Войти с Telegram",
                    isEnabled: true,
                    action: nil
                )
            }
            .padding(.horizontal)
    }
}
