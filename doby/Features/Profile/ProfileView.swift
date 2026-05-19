import SwiftUI

struct ProfileView: View {
    @Environment(PetStorage.self) private var petStorage
    @Environment(ProfileRouter.self) private var router
    @Environment(PrimaryColorService.self) var primaryColorService
    
    @State private var viewModel: ProfileViewModel
    @State private var profilePetsViewModel: ProfilePetsViewModel
    @State private var profileOrdersViewModel: ProfileOrdersViewModel
    
    @State private var currentPage: Int = 1
    @State private var selection: ProfileDetailsTab = .about
    
    let options = ProfileDetailsTab.allCases
    
    let openSettings: () -> Void
    let openPetAdding: () -> Void
    let openPetProfile: (Int) -> Void
    
    init(
        userRepository: UserRepositoryProtocol,
        petRepository: PetRepositoryProtocol,
        storage: UserStorage,
        openSettings: @escaping () -> Void,
        openPetAdding: @escaping () -> Void,
        opentPetProfile: @escaping (Int) -> Void,
    ) {
        _viewModel = State(initialValue: ProfileViewModel(
            userRepository: userRepository,
            petRepository: petRepository,
            storage: storage
        ))
        _profilePetsViewModel = State(initialValue: ProfilePetsViewModel(
            petRepository: petRepository
        ))
        _profileOrdersViewModel = State(initialValue: ProfileOrdersViewModel())
        
        self.openSettings = openSettings
        self.openPetAdding = openPetAdding
        self.openPetProfile = opentPetProfile
    }
    
    var body: some View {
        ScrollView {
            // MARK: - Шапка профиля
            ProfileHeaderView(
                uuid: viewModel.user?.uuid,
                username: viewModel.user?.username,
                firstName: viewModel.user?.firstName,
                lastName: viewModel.user?.lastName
            )
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            // MARK: - Секция с питомцами юзера
            PrimaryCollapsibleSection(title: "Мои питомцы") {
                ProfilePetsView(
                    currentPage: profilePetsViewModel.currentPage,
                    pets: petStorage.pets,
                    openPetAdding: { openPetAdding() },
                    openPetProfile: { id in
                        openPetProfile(id)
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
                    buttonAction: { openSettings() }
                )
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            // MARK: - Секция с историей заказов
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
        .padding(.top, 60)
        .ignoresSafeArea(edges: .top)
        .scrollIndicators(.hidden)
        .profileToolbar(
            onEditTap: { openSettings() },
            onQRScanTap: {}
        )
        .refreshable {
            await viewModel.fetchUser()
        }
    }
}

#Preview {
    ProfileView(
        userRepository: MockUserRepository(),
        petRepository: MockPetRepository(),
        storage: UserStorage(),
        openSettings: {},
        openPetAdding: {},
        opentPetProfile: { id in }
    )
    .PreviewAppEnvironment()
    .environment(PetStorage())
    .environment(ProfileRouter())
}
