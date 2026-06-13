import SwiftUI
import Kingfisher

struct PrimaryGallary: View {
    
    @State var fullName: String
    @State var photos: [Photo]
    
    let hidePhotoGallary: () -> Void
    
    @State private var currentPage: Int?
    
    private var baseURL = APIConstants.getImageBaseURL()
    private func getPhotoURL(imageURL: String) -> URL? {
        URL(string: baseURL.absoluteString)?.appendingPathComponent(imageURL)
    }
    
    init(
        fullName: String,
        photos: [Photo],
        hidePhotoGallary: @escaping () -> Void
    ) {
        self.fullName = fullName
        self.photos = photos
        self.hidePhotoGallary = hidePhotoGallary
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                GeometryReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 0) {
                            ForEach(Array(photos.enumerated()), id: \.offset) { index, photo in
                                PrimaryZoomableView {
                                    VStack {
                                        Spacer()
                                        
                                        KFImage(getPhotoURL(imageURL: photo.imageURL))
                                            .resizable()
                                            .scaledToFit()
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .border(.blue)
                                }
                                .frame(
                                    width: proxy.size.width,
                                    height: proxy.size.height
                                )
                                .border(.red)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollPosition(id: $currentPage)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                PrimaryGalleryPagination(
                    currentPage: currentPage ?? 0,
                    itemsCount: photos.count,
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .navigationTitle(fullName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button("Изм.") {
                    
                }
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .overlay(alignment: .topLeading) {
            Button("Закрыть", systemImage: "") {
                hidePhotoGallary()
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    PrimaryGallary(
        fullName: "UserName",
        photos: [
            Photo(
                id: 1,
                imageURL: "MockUserIcon",
                orderNumber: 1,
                isMain: true
            ),
            Photo(
                id: 2,
                imageURL: "MockUserIcon",
                orderNumber: 2,
                isMain: false
            ),
            Photo(
                id: 3,
                imageURL: "MockUserIcon",
                orderNumber: 3,
                isMain: false
            ),
        ],
        hidePhotoGallary: {}
    )
    .PreviewAppEnvironment()
}
