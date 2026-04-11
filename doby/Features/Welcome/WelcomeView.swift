import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var router: AppRouter
    
    @StateObject private var viewModel = WelcomeViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: - фоновое изображение
            Image("welcomeImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .containerRelativeFrame(.horizontal)
                .clipped()
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                // MARK: - Пагинация для слайдера
                PrimaryPagination(numberOfPages: viewModel.slides.count, currentPage: viewModel.currentPage)
                
                // MARK: - Сам слайдер
                PrimarySlider(
                    currentPage: $viewModel.currentPage,
                    items: viewModel.slides,
                ) { slide in
                    WelcomeSlideContentView(slide: slide)
                }
                
                // MARK: - Кнопка для перехода на другой экран
                PrimaryButton(
                    title: "Продолжить",
                    isEnabled: viewModel.isLastSlide,
                    action: {
                        if viewModel.isLastSlide {
                            router.push(.auth)
                        }
                    },
                )
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 32, trailing: 16))
            .background(.primaryBackground)
            .cornerRadius(16)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    WelcomeView()
        .withAppEnvironment()
}
