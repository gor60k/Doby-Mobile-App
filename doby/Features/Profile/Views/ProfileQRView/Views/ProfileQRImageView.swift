import SwiftUI

struct ProfileQRImageView: View {
    let qrCodeImage: UIImage?
    
    var body: some View {
        VStack(spacing: 18) {
            Group {
                if let qrCodeImage {
                    Image(uiImage: qrCodeImage)
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 220, height: 220)
                        .padding(18)
                        .background(
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .fill(Color.white)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .stroke(Color.black.opacity(0.04), lineWidth: 1)
                        )
                } else {
                    ProgressView()
                        .frame(width: 220, height: 220)
                }
            }

            VStack(spacing: 8) {
                Text("Поделиться профилем")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.primary)

                Text("Отсканируйте QR-код, чтобы быстро открыть профиль")
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 12)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
//        .background(
//            LinearGradient(
//                colors: [
//                    Color.white,
//                    Color.white.opacity(0.96)
//                ],
//                startPoint: .top,
//                endPoint: .bottom
//            )
//        )
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .stroke(Color.white.opacity(0.6), lineWidth: 1)
        )
    }
}
