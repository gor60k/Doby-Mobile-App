import SwiftUI

struct AuthPasswordFieldView: View {
    @EnvironmentObject private var primaryColorService: PrimaryColorService

    let title: String
    let placeholder: String
    let isValid: Bool
    let showsError: Bool
    let errorText: String?
    @Binding var password: String

    @State private var isPasswordVisible = false

    var body: some View {
        PrimaryTextField(
            title: title,
            isValid: isValid,
            showsError: showsError,
            errorText: errorText
        ) {
            HStack(spacing: 8) {
                Group {
                    if isPasswordVisible {
                        TextField(placeholder, text: $password)
                    } else {
                        SecureField(placeholder, text: $password)
                    }
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textContentType(.password)

                Button {
                    isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .frame(height: 22)
                        .foregroundColor(primaryColorService.currentColor.color)
                }
            }
        }
    }
}
