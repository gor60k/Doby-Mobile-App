import SwiftUI
import PhotosUI

struct SettingsView: View {
    @EnvironmentObject private var router: AppRouter
    
    @State private var viewModel = SettingsViewModel()
    @State private var authViewModel = AuthViewModel()
    @State private var selectedAvatarItem: PhotosPickerItem?
    @State private var selectedAvatarImage: UIImage?
    
    var body: some View {
        Form {
            Section {
                VStack(spacing: 16) {
                    PhotosPicker(selection: $selectedAvatarItem, matching: .images) {
                        VStack(spacing: 10) {
                            ZStack(alignment: .bottomTrailing) {
                                Group {
                                    if let selectedAvatarImage {
                                        Image(uiImage: selectedAvatarImage)
                                            .resizable()
                                            .scaledToFill()
                                    } else {
                                        Circle()
                                            .fill(Color.secondary.opacity(0.12))
                                            .overlay {
                                                Image(systemName: "person.fill")
                                                    .font(.system(size: 28))
                                                    .foregroundColor(.secondary)
                                            }
                                    }
                                }
                                .frame(width: 88, height: 88)
                                .clipShape(Circle())
                                
                                ZStack {
                                    Circle()
                                        .fill(Color.accentColor)
                                        .frame(width: 28, height: 28)
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }
                            
                            Text(selectedAvatarImage == nil ? "Загрузить аватар" : "Сменить аватар")
                                .font(.subheadline.weight(.medium))
                                .foregroundColor(.accentColor)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    VStack(spacing: 4) {
                        Text("Профиль")
                            .font(.headline)
                        Text("Управляйте личными данными и настройками аккаунта")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            }
            
            Section("Личные данные") {
                TextField("Имя", text: $viewModel.name)
                    .textInputAutocapitalization(.words)
                
                TextField("Фамилия", text: $viewModel.surname)
                    .textInputAutocapitalization(.words)
                
                TextField("Номер телефона", text: $viewModel.phone)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
                
                TextField("Город", text: $viewModel.city.name)
                    .textInputAutocapitalization(.words)
            }
            
            Section("Данные аккаунта") {
                TextField("Имя пользователя", text: $viewModel.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.username)
                
                TextField("Почта", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)
            }
            
            Section("Питомцы и догситтинг") {
                Button(action: {
                    router.push(.petSettings)
                }) {
                    settingsRow(title: "Настройки питомцев", systemImage: "pawprint.fill")
                }
                .buttonStyle(.plain)
                
                Button(action: {
//                    router.push(.settings(.dogsitter))
                }) {
                    settingsRow(title: "Стать догситтером", systemImage: "figure.walk")
                }
                .buttonStyle(.plain)
            }
            
            Section("Приложение") {
                Button(action: {
                    router.push(.settings(.appearance))
                }) {
                    settingsRow(title: "Оформление", systemImage: "paintbrush.fill")
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    router.push(.settings(.privacy))
                }) {
                    settingsRow(title: "Безопасность", systemImage: "lock.fill")
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    router.push(.settings(.notifications))
                }) {
                    settingsRow(title: "Уведомления", systemImage: "bell.badge.fill")
                }
                .buttonStyle(.plain)
            }
            
            Section("Аккаунт") {
                Button(action: {
                    Task {
                        await authViewModel.logout()
                        await MainActor.run {
                            router.refreshStartDestination(for: SessionService.shared)
                            router.popToRoot()
                        }
                    }
                }) {
                    Text("Выйти")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Button(action: {
                    Task {
                        await authViewModel.deleteMe()
                        await MainActor.run {
                            router.popToRoot()
                        }
                    }
                }) {
                    Text("Удалить аккаунт")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Настройки")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: selectedAvatarItem) {
            guard let selectedAvatarItem else { return }
            guard let data = try? await selectedAvatarItem.loadTransferable(type: Data.self),
                  let image = UIImage(data: data) else { return }
            await MainActor.run {
                selectedAvatarImage = image
            }
        }
    }
    
    @ViewBuilder
    private func settingsRow(title: String, systemImage: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .foregroundColor(.accentColor)
                .frame(width: 20)
            
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundColor(.secondary)
        }
        .contentShape(Rectangle())
        .padding(.vertical, 4)
    }
}

#Preview {
    SettingsView()
        .withAppEnvironment()
}
