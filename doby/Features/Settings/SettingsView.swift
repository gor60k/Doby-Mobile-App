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
            
            SettingsPetServicesView(action: { router.push(.petSettings) })
            
            SettingsAppView(
                appearanceAction: {
                    router.push(.settings(.appearance))
                },
                privacyAction: {
                    router.push(.settings(.privacy))
                },
                notificationsAction: {
                    router.push(.settings(.notifications))
                }
            )
            
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
}

#Preview {
    SettingsView()
        .withAppEnvironment()
}
