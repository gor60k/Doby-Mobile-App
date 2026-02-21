import UIKit
import PhoneNumberKit

class PhoneNumberCoordinator: NSObject {
    var parent: PhoneNumberTextFieldView
    
    init(_ parent: PhoneNumberTextFieldView) {
        self.parent = parent
    }
    
    @objc func textFieldDidChange(_ textField: PhoneNumberTextField) {
        parent.phoneNumber = textField.text ?? ""
        parent.isValid = textField.isValidNumber
    }
}

