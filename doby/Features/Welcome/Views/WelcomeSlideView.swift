import SwiftUI

struct WelcomeSlideView: View {
    @Binding var currentPage: Int
    let slides: [WelcomeSlide]
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(slides) { slide in
                VStack(spacing: 16) {
                    Text(slide.title)
                        .style(AppTextStyles.largeTitleBold)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                    Text(slide.subtitle)
                        .style(AppTextStyles.headlineMedium)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(.white)
                .tag(slide.id)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 160)
    }
}

#Preview {
    let mockSlides = [
        WelcomeSlide(id: 0, title: "Добро пожаловать", subtitle: "Это первое описание нашего крутого приложения"),
        WelcomeSlide(id: 1, title: "Второй слайд", subtitle: "Рассказываем о функциях подробнее"),
        WelcomeSlide(id: 2, title: "Поехали!", subtitle: "Начните использовать приложение прямо сейчас")
    ]
    
    ZStack {
        Color.gray.ignoresSafeArea()
        WelcomeSlideView(
            currentPage: .constant(0),
            slides: mockSlides
        )
    }
}
