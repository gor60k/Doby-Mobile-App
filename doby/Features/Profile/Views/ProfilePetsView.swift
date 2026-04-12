import SwiftUI

struct ProfilePetsView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    @State var currentPage: Int = 0
    @State var slides: [ProfilePetsSlide]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
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
            .overlay(alignment: .topTrailing) {
                UtilityButton(
                    action: {
                        router.push(.petAdding)
                    },
                    icon: "plus"
                )
                .padding(.vertical, 16)
                .padding(.trailing, 16)
            }
        }
    }
}
