import SwiftUI

struct ProfileScreen: View {
    @Environment(PetStorage.self) private var petStorage
    @Environment(PrimaryColorService.self) var primaryColorService
    @Environment(ViewContextService.self) var viewContextService
    
    @State private var viewModel: ProfileViewModel
    @State private var profilePetsViewModel: ProfilePetsViewModel
    @State private var profileOrdersViewModel: ProfileOrdersViewModel
    
    @State private var currentPage: Int = 1
    @State private var selection: ProfileDetailsTab = .about
    
    @State private var showQRSheet = false
    @State private var showPhotoGallery = false
    
    let options = ProfileDetailsTab.allCases
    
    let profileNavigation: ProfileNavigation
    
    init(
        viewModel: ProfileViewModel,
        profilePetsViewModel: ProfilePetsViewModel,
        profileOrdersViewModel: ProfileOrdersViewModel,
        
        profileNavigation: ProfileNavigation,
    ) {
        _viewModel = State(initialValue: viewModel)
        _profilePetsViewModel = State(initialValue: profilePetsViewModel)
        _profileOrdersViewModel = State(initialValue: profileOrdersViewModel)
        
        self.profileNavigation = profileNavigation
    }
    
    var body: some View {
        ScrollView {
            // MARK: - Шапка профиля
            ProfileHeaderView(
                uuid: viewModel.user?.uuid,
                photo: viewModel.user?.photos?.first,
                username: viewModel.user?.username,
                firstName: viewModel.user?.firstName,
                lastName: viewModel.user?.lastName,
                cityName: viewModel.user?.city?.name,
                
                showPhotoGallery: { showPhotoGallery = true }
            )
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            // MARK: - Секция с питомцами юзера
            PrimaryCollapsibleSection(title: "Питомцы") {
                ProfilePetsView(
                    currentPage: profilePetsViewModel.currentPage,
                    pets: petStorage.pets ?? [],
                    openPetAdding: { profileNavigation.openPetAdding() },
                    openPetProfile: { id in
                        profileNavigation.openPetProfile(id)
                    }
                )
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            // MARK: - Секция с деталями юзера (обо мне и отзывы)
            PrimaryCollapsibleSection(title: "Подробнее") {
                ProfileDetailsView(
                    selection: $selection,
                    aboutValue: .about,
                    feedbackValue: .feedback,
                    options: options,
                    title: { $0.rawValue },
                    bio: viewModel.user?.bio ?? "",
                    buttonAction: { profileNavigation.openSettings() }
                )
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            // MARK: - Секция с историей заказов
            if viewContextService.isCurrentUser {
                PrimaryCollapsibleSection(title: "История заказов") {
                    VStack(spacing: 12) {
                        ForEach(profileOrdersViewModel.orders, id: \.self) { order in
                            PrimaryOrderCard(order: order)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
        .navigationTitle("Профиль")
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .toolbar(viewContextService.isCurrentUser ? .visible : .hidden, for: .tabBar)
        .profileToolbar(
            isCurrentUser: viewModel.isCurrentUser,
            onEditTap: { profileNavigation.openSettings() },
            onQRScanTap: {
                showQRSheet = true
            }
        )
        .safeAreaInset(edge: .bottom) {
            if !viewContextService.isCurrentUser {
                VStack {
                    PrimaryButton(
                        title: "Отправить запрос",
                        action: {
                            Task {
                                await viewModel.createChat()
                            }
                        }
                    )
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $showQRSheet) {
            ProfileQRScreen(
                showQRSheet: $showQRSheet,
                userUUID: viewModel.user?.uuid ?? "",
                userImageURL: "",
                onScanCompleted: { showQRSheet = false }
            )
        }
        .fullScreenCover(isPresented: $showPhotoGallery) {
            PrimaryGallary(
                fullName: viewModel.user?.username ?? "",
                photos: viewModel.user?.photos ?? [],
                hidePhotoGallary: {
                    showPhotoGallery = false
                }
            )
        }
        .task {
            await viewModel.load()
        }
        .refreshable {
            await viewModel.load()
        }
    }
}
