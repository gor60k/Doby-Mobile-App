import SwiftUI

struct SettingsPrivacyView: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    @State private var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Смена пароля")) {
                    TextField("Старый пароль", text: $viewModel.password)
                    TextField("Придумайте новый пароль", text: $viewModel.newPassword)
                    TextField("Повторите новый пароль", text: $viewModel.confirmNewPassword)
                }
                
                Button(action: {}) {
                    Text("Сменить пароль")
                        .foregroundColor(primaryColorService.currentColor.color)
                }
            }
        }
    }
}

#Preview {
    SettingsPrivacyView()
        .withAppEnvironment()
}
