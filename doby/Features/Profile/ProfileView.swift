import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    @StateObject private var viewModel = ProfileViewModel()
    
    @State private var authViewModel = AuthViewModel()
    @State private var currentPage: Int = 1
    
    private var session = SessionService.shared
    
    @State private var selection = "Обо мне"
    let options = ["Обо мне", "Отзывы"]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                ProfileHeaderView(user: session.currentUser)
                
                DividerWithTitle(title: "Мои питомцы")
                
                ProfilePetsView(
                    currentPage: viewModel.currentPage,
                    slides: viewModel.slides
                )
                
                DividerWithTitle(title: "Подробнее")
                
                PrimaryPicker(
                    selection: $selection,
                    options: options
                )

                VStack(alignment: .leading) {
                    if selection == "Обо мне" {
                        ProfileAboutView(bio: "Здесь описание пользователя")
                        
                    } else if selection == "Отзывы" {
                        VStack(spacing: 10) {
                            ForEach(0..<3, id: \.self) { _ in
                                PrimaryFeedback()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
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
}

#Preview {
    ProfileView()
        .withAppEnvironment()
}
