import SwiftUI
import PhotosUI

struct SettingsView: View {
    @Environment(ProfileRouter.self) private var router
    @Environment(UserStorage.self) private var userStorage
    @Environment(\.appContainer) private var appContainer
    
    private var sessionService: SessionService { appContainer.sessionService }
    
    @State private var viewModel: SettingsViewModel
    
    @State private var selectedAvatarItem: PhotosPickerItem?
    @State private var selectedAvatarImage: UIImage?
    
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
        authRepository: AuthRepositoryProtocol,
        userRepository: UserRepositoryProtocol,
        userStorage: UserStorageProtocol,
        cityStorage: CityStorageProtocol,
        
        openSettingsAppearance: @escaping () -> Void,
        openSettingsPrivacy: @escaping () -> Void,
        openSettingsNotifications: @escaping () -> Void
    ) {
        _viewModel = State(initialValue: SettingsViewModel(
            authRespository: authRepository,
            userRepository: userRepository,
            userStorage: userStorage,
            cityStorage: cityStorage
        ))
        
        self.openSettingsAppearance = openSettingsAppearance
        self.openSettingsPrivacy = openSettingsPrivacy
        self.openSettingsNotifications = openSettingsNotifications
    }
    
    var body: some View {
        Form {
            SettingsPhotosPickerView(
                selectedAvatarItem: $selectedAvatarItem,
                selectedAvatarImage: $selectedAvatarImage
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
            guard let data = try? await selectedAvatarItem.loadTransferable(type: Data.self),
                  let image = UIImage(data: data) else { return }
            await MainActor.run {
                selectedAvatarImage = image
            }
        }
        .task {
            await viewModel.fetchCities()
        }
    }
}

#Preview {
    SettingsView(
        authRepository: MockAuthRepository(),
        userRepository: MockUserRepository(),
        userStorage: UserStorage(),
        cityStorage: CityStorage(),
        openSettingsAppearance: {},
        openSettingsPrivacy: {},
        openSettingsNotifications: {}
    )
    .PreviewAppEnvironment()
    .environment(ProfileRouter())
    .environment(UserStorage())
}
