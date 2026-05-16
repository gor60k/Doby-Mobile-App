import SwiftUI
import PhotosUI

struct SettingsView: View {
    @Environment(ProfileRouter.self) private var router
    @Environment(AppRouter.self) private var appRoute
    @Environment(\.userStorage) private var userStorage
    
    @State private var viewModel: SettingsViewModel
    
    @State private var selectedAvatarItem: PhotosPickerItem?
    @State private var selectedAvatarImage: UIImage?
    
    init(
        authRepository: AuthRepositoryProtocol,
        userRepository: UserRepositoryProtocol,
        userStorage: UserStorage
    ) {
        _viewModel = State(initialValue: SettingsViewModel(
            authRespository: authRepository,
            userRepository: userRepository,
            userStorage: userStorage
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
                city: $viewModel.city
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
                Button(action: {
                    Task {
                        await viewModel.logout()
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
                Button("Готово", action: {
                    Task {
                        await viewModel.updateUser()
                        router.pop()
                    }
                })
                    .tint(.primary)
            }
        }
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
    SettingsView(
        authRepository: MockAuthRepository(),
        userRepository: MockUserRepository(),
        userStorage: UserStorage()
    )
    .appEnvironment(
        container: AppContainer(),
        appRouter: AppRouter(),
        themeService: ThemeService(),
        primaryColorService: PrimaryColorService()
    )
    .environment(ProfileRouter())
    .environment(UserStorage())
}
