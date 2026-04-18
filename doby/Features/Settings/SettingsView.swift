import SwiftUI
import PhotosUI

struct SettingsView: View {
    @EnvironmentObject private var router: ProfileRouter
    @EnvironmentObject private var appRoute: AppRouter
    
    @State private var viewModel = SettingsViewModel()
    @State private var authViewModel = AuthViewModel()
    @State private var selectedAvatarItem: PhotosPickerItem?
    @State private var selectedAvatarImage: UIImage?
    
    var body: some View {
        Form {
            SettingsPhotosPickerView(
                selectedAvatarItem: $selectedAvatarItem,
                selectedAvatarImage: $selectedAvatarImage
            )
            
            SettingsPersonalInfoView(
                name: $viewModel.name,
                surname: $viewModel.surname,
                phone: $viewModel.phone,
                city: $viewModel.city
            )
            
            SettingsAccountInfoView(
                username: $viewModel.username,
                email: $viewModel.email
            )
            
            SettingsPetServicesView(action: {
                router.push(.petSettings)
            })
            
            SettingsAppView(
                appearanceAction: {
                    router.push(.settingsAppearance)
                },
                privacyAction: {
                    router.push(.settingsPrivacy)
                },
                notificationsAction: {
                    router.push(.settingsNotifications)
                }
            )
            
            Section("Аккаунт") {
                Button(action: {
                    Task {
                        await authViewModel.logout()
                        await MainActor.run {
                            appRoute.goToAuth()
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
                            appRoute.goToWelcome()
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
}

#Preview {
    SettingsView()
        .withAppEnvironment()
}
