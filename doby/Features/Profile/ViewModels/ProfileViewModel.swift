import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    
    let avatarSlides: [ProfileAvatarSlide]
    
    init(avatarSlides: [ProfileAvatarSlide]) {
        self.avatarSlides = avatarSlides
    }
}
