import SwiftUI
import Combine

class WelcomeSlideViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    @Published var navigateToRoleSelection: Bool = false
    
    let slides: [WelcomeSlide]
    
    init(slides: [WelcomeSlide]) {
        self.slides = slides
    }
    
    var isLastSlide: Bool {
        currentPage == slides.count - 1
    }
    
    func continueTapped() {
        if isLastSlide {
            navigateToRoleSelection = true
        }
    }
}
