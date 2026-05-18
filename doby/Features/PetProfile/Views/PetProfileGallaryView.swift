import SwiftUI
import Kingfisher

struct PetProfileGallaryView: View {
    @Binding var currentPage: Int
    let items: [PetPhoto]
    
    private let baseURL = APIConstants.baseURL
    
    private func getFullImageURL(imageURL: String) -> URL? {
        return URL(string: baseURL.absoluteString)?.appendingPathComponent(imageURL)
    }
    
    var body: some View {
        ZStack {
            PrimarySlider(
                currentPage: $currentPage,
                items: items,
            ) { slide in
                KFImage(getFullImageURL(imageURL: slide.imageURL))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(height: 350)
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
