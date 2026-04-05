import SwiftUI

enum ProfileDetailsTab: String, CaseIterable {
    case about = "Обо мне"
    case feedback = "Отзывы"
}

struct ProfileView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    @StateObject private var viewModel = ProfileViewModel()
    
    @State private var authViewModel = AuthViewModel()
    @State private var currentPage: Int = 1
    
    @State private var selection: ProfileDetailsTab = .about
    let options = ProfileDetailsTab.allCases
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                ProfileHeaderView(user: session.currentUser)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                PrimaryCollapsibleSection(title: "Мои питомцы") {
                    ProfilePetsView(
                        currentPage: viewModel.currentPage,
                        slides: viewModel.slides
                    )
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
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
                Button(action: {router.push(.settings)}) {
                    Text("Изм.")
                        .style(AppTextStyle.Presets.bodySemibold)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .glassEffect(
                    .regular
                        .interactive()
                )
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.primaryBackground)
    }
    
    private var session = SessionService.shared
}

#Preview {
    ProfileView()
        .withAppEnvironment()
}
