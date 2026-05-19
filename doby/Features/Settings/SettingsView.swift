import SwiftUI
import PhotosUI

struct SettingsView: View {
    @Environment(ProfileRouter.self) private var router
    @Environment(UserStorage.self) private var userStorage
    @Environment(\.appContainer) private var appContainer
    
    private var sessionService: SessionService { appContainer.services.sessionService }
    
    @State private var viewModel: SettingsViewModel
    
    @State private var selectedAvatarItem: PhotosPickerItem?
    @State private var selectedAvatarImage: UIImage?
    
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
        cityStorage: CityStorageProtocol
    ) {
        _viewModel = State(initialValue: SettingsViewModel(
            authRespository: authRepository,
            userRepository: userRepository,
            userStorage: userStorage,
            cityStorage: cityStorage
        ))
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
        cityStorage: CityStorage()
    )
    .PreviewAppEnvironment()
    .environment(ProfileRouter())
    .environment(UserStorage())
}
