import SwiftUI

struct WelcomeSlideContentView: View {
    let slide: WelcomeSlide
    
    var body: some View {
        VStack(spacing: 16) {
            PrimaryText(
                text: slide.title,
                style: .subtitle
            )
            .multilineTextAlignment(.center)
            
            PrimaryText(
                text: slide.subtitle,
                style: .secondaryContent
            )
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .top)
    }
}
