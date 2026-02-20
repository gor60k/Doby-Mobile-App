import SwiftUI
import PhoneNumberKit

struct PhoneNumberTextFieldView: UIViewRepresentable {
    @Binding var phoneNumber: String
    @Binding var isValid: Bool
    
    let phoneNumberKit = PhoneNumberUtility()
    
    func makeUIView(context: Context) -> PhoneNumberTextField {
        let textField = PhoneNumberTextField(utility: phoneNumberKit)
        
        textField.withExamplePlaceholder = true
        textField.withFlag = true
        textField.withPrefix = true
        
        textField.placeholder = "Введите номер"
        textField.becomeFirstResponder()
        
        textField.addTarget(
            context.coordinator,
            action: #selector(PhoneNumberCoordinator.textFieldDidChange),
            for: .editingChanged
        )
        
        return textField
    }
    
    func updateUIView(_ uiView: PhoneNumberTextField, context: Context) {
        uiView.text = phoneNumber
    }
    
    func makeCoordinator() -> PhoneNumberCoordinator {
        PhoneNumberCoordinator(self)
    }
}
