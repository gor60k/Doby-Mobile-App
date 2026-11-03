import SwiftUI

//TODO: - Доделать экран с qr и галереей

struct ProfileScreen: View {
    @State private var viewModel: ProfileViewModel
    @State private var ordersViewModel: ProfileOrdersViewModel

    @State private var currentPage = 1
    @State private var showQRSheet = false
    @State private var showPhotoGallery = false

    let profileNavigation: ProfileNavigation

    init(
        viewModel: ProfileViewModel,
        ordersViewModel: ProfileOrdersViewModel,
        profileNavigation: ProfileNavigation
    ) {
        _viewModel = State(initialValue: viewModel)
        _ordersViewModel = State(initialValue: ordersViewModel)
        self.profileNavigation = profileNavigation
    }

    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .idle:
                Color.clear
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)
            case .loaded(let content):
                ProfileContentView(
                    user: content.user,
                    orders: ordersViewModel.orders,
                    taget: viewModel.target,
                    profileNavigation: profileNavigation,
                    onPhotoTap: { showPhotoGallery = true },
                    currentPage: $currentPage
                )
            case .error(let error):
                Text(error.localizedDescription)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .navigationTitle("Профиль")
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .toolbar(viewModel.isCurrentUser ? .visible : .hidden, for: .tabBar)
        .profileToolbar(
            isCurrentUser: viewModel.isCurrentUser,
            onEditTap: { profileNavigation.openSettings() },
            onQRScanTap: { showQRSheet = true }
        )
//        .fullScreenCover(isPresented: $showQRSheet) {
//            if let user = viewModel.user {
//                ProfileQRScreen(
//                    showQRSheet: $showQRSheet,
//                    userUUID: user.uuid,
//                    userImageURL: user.photos?.first ?? [],
//                    onScanCompleted: { showQRSheet = false }
//                )
//            }
//        }
//        .fullScreenCover(isPresented: $showPhotoGallery) {
//            if let user = viewModel.user {
//                PrimaryGallary(
//                    fullName: user.username,
//                    photos: user.photos,
//                    hidePhotoGallary: { showPhotoGallery = false }
//                )
//            }
//        }
        .task {
            await viewModel.loadIfNeeded()
//            await ordersViewModel.loadIfNeeded()
        }
        .refreshable {
            await viewModel.refresh()
//            await ordersViewModel.refresh()
        }
    }
}
