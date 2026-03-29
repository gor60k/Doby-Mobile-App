import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var router: AppRouter
    
    @StateObject private var viewModel = WelcomeSlideViewModel(slides: [
        WelcomeSlide(id: 0, title: "Найдите надежного ситтера", subtitle: "Просмотрите профили и выберете того, кому доверите любимца"),
        WelcomeSlide(id: 1, title: "Договоритесь в чате", subtitle: "Обсудите все детали ухода прямо в приложении"),
        WelcomeSlide(id: 2, title: "Оплатите безопасно", subtitle: "Используйте надежные встроенные платежи без риска")
    ])
    
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
                PrimarySlider(currentPage: $viewModel.currentPage, items: viewModel.slides) { slide in
                    WelcomeSlideContentView(slide: slide)
                }
                .frame(height: 160)
                
                // MARK: - Кнопка для перехода на другой экран
                PrimaryButton(
                    title: "Продолжить",
                    isEnabled: viewModel.isLastSlide,
                    action: {
                        if viewModel.isLastSlide {
                            router.push(.auth)
                        }
                    }
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
}
