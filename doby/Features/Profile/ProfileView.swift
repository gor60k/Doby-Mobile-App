import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    @State private var viewModel = ProfileViewModel()
    private var session = SessionService.shared
    
    @State private var currentPage: Int = 1
    @State private var selection: ProfileDetailsTab = .about
    let options = ProfileDetailsTab.allCases
    
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
                        ProfileOrderCardView(order: order)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .scrollIndicators(.hidden)
        .overlay(alignment: .topTrailing) {
            UtilityButton(
                action: {
                    router.push(.profile(.settings))
                },
                title: "Изм."
            )
            .padding(.trailing, 16)
        }
    }
}

#Preview {
    ProfileView()
        .withAppEnvironment()
}
