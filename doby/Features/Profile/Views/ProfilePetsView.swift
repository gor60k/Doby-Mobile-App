import SwiftUI

struct ProfilePetsView: View {
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    @State var currentPage: Int = 0
    @State var slides: [ProfilePetsSlide]
    
    var body: some View {
        VStack {
            VStack {
                Button(action: {}) {
                    HStack(spacing: 6) {
                        Text("Добавить питомца")
                            .font(.system(.caption, design: .rounded))
                            .foregroundColor(.white)
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .glassEffect(
                    .regular
                        .tint(primaryColorService.currentColor.color)
                        .interactive(),
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
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
}
