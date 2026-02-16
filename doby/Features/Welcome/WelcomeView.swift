import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeSlideViewModel(slides: [
        WelcomeSlide(id: 0, title: "Найдите надежного ситтера", subtitle: "Просмотрите профили и выберете того, кому доверите любимца"),
        WelcomeSlide(id: 1, title: "Договоритесь в чате", subtitle: "Обсудите все детали ухода прямо в приложении"),
        WelcomeSlide(id: 2, title: "Оплатите безопасно", subtitle: "Используйте надежные встроенные платежи без риска")
    ])
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("welcomeImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .containerRelativeFrame(.horizontal)
                .clipped()
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                WelcomePageIndicatorView(numberOfPages: viewModel.slides.count, currentPage: viewModel.currentPage)
                WelcomeSlideView(currentPage: $viewModel.currentPage, slides: viewModel.slides)
                PrimaryButton(
                    title: "Продолжить",
                    isEnabled: viewModel.isLastSlide,
                    action: viewModel.continueTapped
                )
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 32, trailing: 16))
            .background(.white)
            .cornerRadius(16)
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationDestination(isPresented: $viewModel.navigateToRoleSelection) {
            RoleView()
        }
    }
}

#Preview {
    WelcomeView()
}
