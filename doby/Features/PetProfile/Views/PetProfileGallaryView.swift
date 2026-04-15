import SwiftUI

struct PetProfileGallaryView: View {
    @Binding var currentPage: Int
    let items: [PetAvaratSlide]
    
    var body: some View {
        ZStack {
            PrimarySlider(
                currentPage: $currentPage,
                items: items,
            ) { slide in
                Image(slide.image)
                    .resizable()
                    .scaledToFill()
            }
            
            PrimaryGalleryPagination(
                currentPage: currentPage,
                itemsCount: items.count
            )
        }
        .frame(maxWidth: .infinity, maxHeight: 350, alignment: .bottom)
    }
}

struct PrimaryGalleryPagination: View {
    let currentPage: Int
    let itemsCount: Int
    
    var body: some View {
        HStack {
            Text("\(currentPage + 1) / \(itemsCount)")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.black.opacity(0.5))
                .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .padding(.horizontal)
        .padding(.bottom, 24)
    }
}
