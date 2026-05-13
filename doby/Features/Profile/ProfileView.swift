import SwiftUI

struct ProfileView: View {
    @Environment(ProfileRouter.self) private var router
    @Environment(PrimaryColorService.self) var primaryColorService
    
    @State private var viewModel: ProfileViewModel
    
    @State private var currentPage: Int = 1
    @State private var selection: ProfileDetailsTab = .about
    let options = ProfileDetailsTab.allCases
    
    init(
        userRepository: UserRepositoryProtocol,
        petRepository: PetRepositoryProtocol,
    ) {
        _viewModel = State(initialValue: ProfileViewModel(
            userRepository: userRepository,
            petRepository: petRepository
        ))
    }
    
    var body: some View {
        ScrollView {
            // MARK: - Шапка профиля
            ProfileHeaderView(user: viewModel.user)
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            // MARK: - Секция с питомцами юзера
            PrimaryCollapsibleSection(title: "Мои питомцы") {
                ProfilePetsView(
                    currentPage: viewModel.currentPage,
                    pets: viewModel.pets
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
                    title: { $0.rawValue }
                )
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            // MARK: - Секция с историей заказов
            PrimaryCollapsibleSection(title: "История заказов") {
                VStack(spacing: 12) {
                    ForEach(viewModel.orders, id: \.self) { order in
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
            onEditTap: { router.push(.settings) },
            onQRScanTap: {}
        )
        .refreshable {
            await viewModel.fetchUser()
            await viewModel.fetchPets()
        }
    }
}
