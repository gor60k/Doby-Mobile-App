import SwiftUI
import PhoneNumberKit

struct OwnerRegistrationView: View {
    @EnvironmentObject private var router: AppRouter
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var phone = ""
    @State private var isPhoneValid = false
    @State private var isHomeActive = false
    
    let selectedRole: String
    
    var body: some View {
            VStack(spacing: 16) {
                PrimaryTextField(title: "Введите имя") {
                    TextField("Имя", text: $name)
                }
                
                PrimaryTextField(title: "Введите номер телефона") {
                    PhoneNumberTextFieldView(phoneNumber: $phone, isValid: $isPhoneValid)
                }
                
                
                PrimaryButton(
                    title: "Зарегистрироваться",
                    isEnabled: isPhoneValid && !name.isEmpty,
                    action: {
                        isHomeActive = true
                        
                        if isHomeActive {
                            dismiss()
                            router.push(.rootTab)
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

#Preview {
    OwnerRegistrationView(selectedRole: "")
}
