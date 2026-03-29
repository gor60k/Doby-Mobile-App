import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: AppRouter
    
    @StateObject private var viewModel = ProfileViewModel(
        avatarSlides: [
            ProfileAvatarSlide(id: 0, image: "ProfileAvatarPlaceholder"),
            ProfileAvatarSlide(id: 1, image: "ProfileAvatarPlaceholder"),
            ProfileAvatarSlide(id: 2, image: "ProfileAvatarPlaceholder"),
        ]
    )
    @State private var authViewModel = AuthViewModel()
    
    private var session = SessionService.shared
    
    var body: some View {
        VStack {
            VStack {
                PrimarySlider(
                    currentPage: $viewModel.currentPage,
                    items: viewModel.avatarSlides
                ) { slide in
                    ProfileAvatarSlideContentView(slide: slide)
                }
                .frame(height: 300)
                .ignoresSafeArea()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -61, trailing: 0))
                
                PrimaryPagination(numberOfPages: viewModel.avatarSlides.count, currentPage: viewModel.currentPage)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text((session.currentUser?.username) ?? "Username")
                            .style(AppTextStyle.Presets.titleBold)
                        
                        Text("Мне 42 года и я очень люблю маленьких собачек")
                        
                        Divider()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("от 4242")
                                    .style(AppTextStyle.Presets.labelSemibold)
                                Text("за сутки")
                                    .style(AppTextStyle.Presets.headlineRegular)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.primaryYellowLight))
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("от 4242")
                                    .style(AppTextStyle.Presets.labelSemibold)
                                Text("за сутки")
                                    .style(AppTextStyle.Presets.headlineRegular)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.primaryYellowLight))
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("от 4242")
                                    .style(AppTextStyle.Presets.labelSemibold)
                                Text("за сутки")
                                    .style(AppTextStyle.Presets.headlineRegular)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.primaryYellowLight))
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    ProfileView()
}
