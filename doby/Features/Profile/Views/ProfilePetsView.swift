import SwiftUI

struct ProfilePetsView: View {
    @State var currentPage: Int = 0
    @State var slides: [ProfilePetsSlide]
    
    
    var body: some View {
        PrimarySlider(
            currentPage: $currentPage,
            items: slides,
        ) { _ in
            ProfilePetCardView()
        }
        .frame(height: 200)
        
        PrimaryPagination(
            numberOfPages: slides.count,
            currentPage: currentPage
        )
    }
}
