import SwiftUI

struct ProfileAvatarSlideContentView: View {
    let slide: ProfileAvatarSlide
    
    var body: some View {
        Image(slide.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
