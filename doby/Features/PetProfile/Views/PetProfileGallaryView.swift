import SwiftUI
import Kingfisher

struct PetProfileGallaryView: View {
    @Binding var currentPage: Int
    let items: [PetPhoto]
    
    var body: some View {
        ZStack {
            PrimarySlider(
                currentPage: $currentPage,
                items: items,
            ) { slide in
                KFImage(URL(string: "https://frowsier-hungerly-thad.ngrok-free.dev\(slide.imageURL)"))
                    .placeholder {
                        SkeletonView()
                    }
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
            
            PrimaryGalleryPagination(
                currentPage: currentPage,
                itemsCount: items.count
            )
        }
        .frame(alignment: .bottom)
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

struct SkeletonView: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            let phase = timeline.date.timeIntervalSinceReferenceDate
            let pulse = 0.5 + 0.5 * sin(phase * 2)

            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.15))
                .overlay(
                    Image(systemName: "pawprint.fill")
                        .font(.system(size: 34))
                        .foregroundStyle(Color.gray.opacity(0.6))
                        .scaleEffect(0.95 + pulse * 0.08)
                        .opacity(0.6 + pulse * 0.3)
                )
                .scaleEffect(0.98 + pulse * 0.02)
                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulse)
        }
    }
}
