import SwiftUI
import PhotosUI

struct SettingsScreen: View {
    @Environment(ProfileRouter.self) private var router
    @Environment(UserStorage.self) private var userStorage
    @Environment(\.appContainer) private var appContainer
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: SettingsViewModel
    
    private var sessionService: SessionService { appContainer.sessionService }
    let settingsNavigation: SettingsNavigation
    
    private func logout() {
        Task {
            await viewModel.logout()
            sessionService.setAuthenticated(false)
        }
    }
    
    private func saveChanges() {
        Task {
            await viewModel.updateUser()
            router.pop()
        }
    }
    
    init(
        viewModel: SettingsViewModel,
        settingsNavigation: SettingsNavigation,
    ) {
        _viewModel = State(initialValue: viewModel)
        self.settingsNavigation = settingsNavigation
    }
    
    var body: some View {
        Form {
            PrimaryPhotoPicker(
                viewModel: viewModel.photoPickerViewModel,
                currentPhotoURL: viewModel.currentPhotoURL,
                onImageReady: { data in
                    await viewModel.uploadPhoto(data)
                },
                
                placeholderIcon: "person.fill",
                title: "Ваш профиль",
                subtitle: "Управляйте своими данными и настройками приложения"
            )
            
            SettingsPersonalInfoView(
                name: $viewModel.personalInfo.firstName,
                surname: $viewModel.personalInfo.lastName,
                phone: $viewModel.personalInfo.phone,
                selectedCityId: $viewModel.selectedCityId,
                cities: viewModel.cities,
            )
            
            SettingsBIOView(bio: $viewModel.bio)
            
            SettingsAccountInfoView(
                email: $viewModel.email
            )
            
            SettingsAppView(
                appearanceAction: { settingsNavigation.openSettingsAppearance() },
                privacyAction: { settingsNavigation.openSettingsPrivacy() },
                notificationsAction: { settingsNavigation.openSettingsNotifications() }
            )
            
            Section("Аккаунт") {
                Button("Выйти") {
                    logout()
                }
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Настройки")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .settingsToolbar(onSave: { saveChanges() })
        .task {
            await viewModel.load()
        }
    }
}

//#Preview {
//    SettingsScreen(
//        viewModel: .mock,
//        settingsNavigation: SettingsNavigation(
//            openSettingsAppearance: {},
//            openSettingsPrivacy: {},
//            openSettingsNotifications: {}
//        )
//    )
//    .PreviewAppEnvironment()
//    .environment(ProfileRouter())
//    .environment(UserStorage())
//}

