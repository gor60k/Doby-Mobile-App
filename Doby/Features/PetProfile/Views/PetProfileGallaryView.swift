import SwiftUI
import Kingfisher

struct PetProfileGallaryView: View {
    @Binding var currentPage: Int
    let items: [PetPhoto]
    
    private let baseURL = APIConstants.getImageBaseURL()
    
    private func getFullImageURL(imageURL: String) -> URL? {
        return URL(string: baseURL.absoluteString)?.appendingPathComponent(imageURL)
    }
    
    private var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    var body: some View {
        ZStack {
            PrimarySlider(
                currentPage: $currentPage,
                items: items,
            ) { slide in
                Group {
                    if isPreview {
                        Image("PetAvatarPlaceholder")
                            .resizable()
                            .scaledToFill()
                    } else {
                        KFImage(getFullImageURL(imageURL: slide.imageURL))
                            .placeholder { ProgressView() }
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(maxHeight: 350)
            }
            
            PrimaryGalleryPagination(
                currentPage: currentPage,
                itemsCount: items.count
            )
        }
        .frame(alignment: .bottom)
        .frame(height: 350)
    }
}


