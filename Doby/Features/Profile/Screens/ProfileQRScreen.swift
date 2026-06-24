import SwiftUI
import Kingfisher
import QRCode
import VisionKit
internal import Vision

struct ProfileQRScreen: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    @Binding var showQRSheet: Bool
    
    @State private var viewModel: ProfileQRViewModel?
    @State private var showScanner = false
    @State private var scannedCode: String?
    @State private var pendingURL: URL?
    
    let userUUID: String
    let userImageURL: String?
    
    let onScanCompleted: () -> Void
    
    private var qrCodeImage: UIImage? {
        return viewModel?.qrImage
    }
    
    private var backgroundImageString: String {
        let color = primaryColorService.primaryColor
        switch color {
        case .yellow: return "QRScreenBackgroundYellow"
        case .blue: return "QRScreenBackgroundBlue"
        case .green: return "QRScreenBackgroundGreen"
        }
        
    }
    
    init(
        showQRSheet: Binding<Bool>,
        userUUID: String,
        userImageURL: String?,
        onScanCompleted: @escaping () -> Void
    ) {
        self._showQRSheet = showQRSheet
        self.userUUID = userUUID
        self.userImageURL = userImageURL
        self.onScanCompleted = onScanCompleted
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 28) {
                ProfileQRAvatarView(avatarURL: viewModel?.avatarURL)

                ProfileQRImageView(qrCodeImage: qrCodeImage)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)

            Spacer()
            
            ProfileQRBottomView(
                showQRSheet: $showQRSheet,
                showScanner: $showScanner
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(8)
        .padding(.bottom, 0)
        .background {
            Image(backgroundImageString)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .fullScreenCover(
            isPresented: $showScanner,
        ) {
            PrimaryQRScannerView(
                onScan: { code in
                    pendingURL = URL(string: code)
                    showScanner = false
                    onScanCompleted()
                },
                onClose: {
                    showScanner = false
                }
            )
        }
        .onChange(of: showScanner) { _, newValue in
            if newValue == false, let url = pendingURL {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url)
                }
                pendingURL = nil
            }
        }
        .task {
            if viewModel == nil {
                viewModel = ProfileQRViewModel(
                    userUUID: userUUID,
                    userImageURL: userImageURL,
                    primaryColor: primaryColorService.primaryColor.color
                )
            }
        }
    }
}

#Preview {
    ProfileQRScreen(
        showQRSheet: .constant(true),
        userUUID: "1",
        userImageURL: "",
        onScanCompleted: {}
    )
    .PreviewAppEnvironment()
}
