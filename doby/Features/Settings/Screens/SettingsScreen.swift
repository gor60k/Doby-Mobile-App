import SwiftUI
import PhotosUI

struct SettingsScreen: View {
    @Environment(ProfileRouter.self) private var router
    @Environment(UserStorage.self) private var userStorage
    @Environment(\.appContainer) private var appContainer
    
    private var sessionService: SessionService { appContainer.sessionService }
    
    @State private var viewModel: SettingsViewModel
    
    @State private var selectedAvatarItem: PhotosPickerItem?
    
    // MARK: - Функции для перехода на дочерние экраны
    let openSettingsAppearance: () -> Void
    let openSettingsPrivacy: () -> Void
    let openSettingsNotifications: () -> Void
    
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
        
        openSettingsAppearance: @escaping () -> Void,
        openSettingsPrivacy: @escaping () -> Void,
        openSettingsNotifications: @escaping () -> Void
    ) {
        _viewModel = State(initialValue: viewModel)
        
        self.openSettingsAppearance = openSettingsAppearance
        self.openSettingsPrivacy = openSettingsPrivacy
        self.openSettingsNotifications = openSettingsNotifications
    }
    
    var body: some View {
        Form {
            SettingsPhotosPickerView(
                selectedAvatarItem: $selectedAvatarItem,
                selectedAvatarImage: $viewModel.selectedAvatarImage
            )
            
            SettingsPersonalInfoView(
                name: $viewModel.firstName,
                surname: $viewModel.lastName,
                phone: $viewModel.phone,
                selectedCityId: $viewModel.selectedCityId,
                cities: viewModel.cities,
            )
            
            SettingsBIOView(bio: $viewModel.bio)
            
            SettingsAccountInfoView(
                email: $viewModel.email
            )
            
//            SettingsPetServicesView(action: {
//                router.push(.petSettings())
//            })
            
            SettingsAppView(
                appearanceAction: { openSettingsAppearance() },
                privacyAction: { openSettingsPrivacy() },
                notificationsAction: { openSettingsNotifications() }
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
        .settingsToolbar(onSave: { saveChanges() })
        .task(id: selectedAvatarItem) {
            guard let selectedAvatarItem else { return }
            await viewModel.handleAvatarSelection(selectedAvatarItem)
        }
        .task {
            await viewModel.fetchCities()
        }
    }
}

#Preview {
    SettingsScreen(
        viewModel: .mock,
        openSettingsAppearance: {},
        openSettingsPrivacy: {},
        openSettingsNotifications: {}
    )
    .PreviewAppEnvironment()
    .environment(ProfileRouter())
    .environment(UserStorage())
}

