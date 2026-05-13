import SwiftUI

struct SettingsPrivacyView: View {
    @Environment(PrimaryColorService.self) var primaryColorService
    
    @State private var viewModel: SettingsPrivacyViewModel
    
    init() {
        _viewModel = State(initialValue: SettingsPrivacyViewModel())
    }
    
    var body: some View {
        Form {
            Section(header: Text("Смена пароля")) {
                TextField("Старый пароль", text: $viewModel.password)
                TextField("Придумайте новый пароль", text: $viewModel.newPassword)
                TextField("Повторите новый пароль", text: $viewModel.confirmNewPassword)
            }
            
            Button(action: {}) {
                Text("Сменить пароль")
                    .foregroundColor(primaryColorService.primaryColor.color)
            }
        }
        .navigationTitle("Приватность")
        .navigationBarTitleDisplayMode(.inline)
    }
}
