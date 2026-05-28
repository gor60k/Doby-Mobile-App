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
    
    let userUUID: String
    let userImageURL: String?
    
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
    ) {
        self._showQRSheet = showQRSheet
        self.userUUID = userUUID
        self.userImageURL = userImageURL
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
//        .background(primaryColorService.primaryColor.color.opacity(0.1))
        .background {
            Image(backgroundImageString)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .fullScreenCover(isPresented: $showScanner) {
            PrimaryQRScannerView(
                onScan: { code in
                    scannedCode = code
                    showScanner = false

                    if let url = URL(string: code) {
                        UIApplication.shared.open(url)
                    }
                },
                onClose: {
                    showScanner = false
                }
            )
            .ignoresSafeArea(.all)
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
        userImageURL: ""
    )
    .PreviewAppEnvironment()
}
