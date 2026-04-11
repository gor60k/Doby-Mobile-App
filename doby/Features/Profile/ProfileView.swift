import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    @StateObject private var viewModel = ProfileViewModel()
    private var session = SessionService.shared
    
    @State private var currentPage: Int = 1
    @State private var selection: ProfileDetailsTab = .about
    let options = ProfileDetailsTab.allCases
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                // MARK: - Шапка профиля
                ProfileHeaderView(user: session.currentUser)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                // MARK: - Секция с питомцами юзера
                PrimaryCollapsibleSection(title: "Мои питомцы") {
                    ProfilePetsView(
                        currentPage: viewModel.currentPage,
                        slides: viewModel.slides
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
            
            VStack {
                UtilityButton(
                    action: {
                        router.push(.settings)
                    },
                    title: "Изм.")
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.primaryBackground)
    }
}

#Preview {
    ProfileView()
        .withAppEnvironment()
}
