import SwiftUI

struct WelcomeSlideContentView: View {
    let slide: WelcomeSlide
    
    var body: some View {
        VStack(spacing: 16) {
            Text(slide.title)
                .style(AppTextStyle.Presets.largeTitleBold)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            Text(slide.subtitle)
                .style(AppTextStyle.Presets.bodyMedium)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
