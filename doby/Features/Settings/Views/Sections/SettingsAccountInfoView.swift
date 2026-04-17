import SwiftUI

struct SettingsAccountInfoView: View {
    @Binding var username: String
    @Binding var email: String
    
    var body: some View {
        Section("Данные аккаунта") {
            TextField("Имя пользователя", text: $username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textContentType(.username)
            
            TextField("Почта", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textContentType(.emailAddress)
        }
    }
}
