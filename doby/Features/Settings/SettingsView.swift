import SwiftUI
import PhotosUI

//TODO: - реализовать изменение данных пользователя
//TODO: - добавить кнопку в тулбар для подтверждения изменения данных✅
//TODO: - вынести тулбар в отдельный модифаер
struct SettingsView: View {
    @Environment(ProfileRouter.self) private var router
    @Environment(AppRouter.self) private var appRoute
    
    @State private var viewModel = SettingsViewModel()
    @State private var authViewModel: AuthViewModel
    
    @State private var selectedAvatarItem: PhotosPickerItem?
    @State private var selectedAvatarImage: UIImage?
    
    init(repository: AuthRepositoryProtocol) {
        _authViewModel = State(initialValue: AuthViewModel(repository: repository))
    }
    
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
                        appRoute.goToAuth()
                    }
                }) {
                    Text("Выйти")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Button(action: {
                    Task {
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Готово", action: {})
                    .tint(.primary)
            }
        }
//        .task(id: selectedAvatarItem) {
//            guard let selectedAvatarItem else { return }
//            guard let data = try? await selectedAvatarItem.loadTransferable(type: Data.self),
//                  let image = UIImage(data: data) else { return }
//            await MainActor.run {
//                selectedAvatarImage = image
//            }
//        }
    }
}

//#Preview {
//    SettingsView(repository: MockAuthRepository())
//        .withAppEnvironment()
//        .environment(ProfileRouter())
//}
