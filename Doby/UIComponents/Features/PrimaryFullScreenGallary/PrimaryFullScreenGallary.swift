import SwiftUI
import Kingfisher

struct PrimaryFullScreenGallary: View {
    
    let fullName: String
    
    @State var viewModel: PrimaryFullScreenGallaryViewModel
    @State private var currentPage = 0
    
    private var baseURL = APIConstants.getImageBaseURL()
    private func getPhotoURL(imageURL: String) -> URL? {
        URL(string: baseURL.absoluteString)?.appendingPathComponent(imageURL)
    }
    
    init(
        fullName: String,
        viewModel: PrimaryFullScreenGallaryViewModel
    ) {
        _viewModel = State(initialValue: viewModel)
        
        self.fullName = fullName
    }
    
    var body: some View {
        VStack {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(Array(viewModel.photos.enumerated()), id: \.element) { index, photo in
                        VStack {
                            Image(photo.imageURL)
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: 350,
                            alignment: .center
                        )
                        .clipped()
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(maxWidth: .infinity, maxHeight: 350)
                
                PrimaryPagination(
                    numberOfPages: viewModel.photos.count,
                    currentPage: currentPage
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
    }
}

#Preview {
    NavigationStack {
        PrimaryFullScreenGallary(
            fullName: "UserName",
            viewModel: .mock
        )
    }
    .PreviewAppEnvironment()
}
