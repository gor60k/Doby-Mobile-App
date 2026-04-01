import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var router: AppRouter
    
    @State private var viewModel = SettingsViewModel()
    @State private var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Основные данные")) {
                    TextField("Имя", text: $viewModel.name)
                    TextField("Фамилия", text: $viewModel.surname)
                    TextField("Номер телефона", text: $viewModel.phone)
                    TextField("Город", text: $viewModel.email)
                }
                
                Section(header: Text("Данные аккаунта")) {
                    TextField("Имя пользователя", text: $viewModel.username)
                    TextField("Почта", text: $viewModel.email)
                }
                
                Button(action: {
                    router.push(.settingsChild(.appearance))
                }) {
                    HStack {
                        Text("Оформление")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                }
                Button(action: {
                    router.push(.settingsChild(.privacy))
                }) {
                    HStack {
                        Text("Безопасность")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                }
                Button(action: {
                    router.push(.settingsChild(.notifications))
                }) {
                    HStack {
                        Text("Уведомления")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                }
            }
            
            Button(action: {
                Task {
                    await authViewModel.logout()
                    await MainActor.run {
                        router.popToRoot()
                    }
                }
            }) {
                Text("Выйти")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    SettingsView()
}
