import SwiftUI

struct AuthEmailFieldView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    let title: String
    let isValid: Bool
    let showsError: Bool
    let errorText: String
    @Binding var email: String
    
    var body: some View {
        PrimaryTextField(
            title: title,
            isValid: isValid,
            showsError: showsError,
            errorText: errorText
        ) {
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
        }
    }
}
