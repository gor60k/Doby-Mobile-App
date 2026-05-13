import SwiftUI

struct SettingsAccountInfoView: View {
    @Binding var email: String
    
    var body: some View {
        Section("Данные аккаунта") {
            TextField("Почта", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textContentType(.emailAddress)
        }
    }
}
