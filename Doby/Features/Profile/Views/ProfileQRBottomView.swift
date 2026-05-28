import SwiftUI

struct ProfileQRBottomView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    @Binding var showQRSheet: Bool
    @Binding var showScanner: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button {
                    showQRSheet.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                        .frame(width: 32, height: 32)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            PrimaryButton(
                title: "Поделиться",
                action: {},
                size: .medium
            )
            
            Button("Сканировать QR-код", systemImage: "qrcode") {
                showScanner = true
            }
            .buttonStyle(.plain)
            .foregroundColor(primaryColorService.primaryColor.color)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
        .padding(.horizontal)
        .padding(.bottom, 32)
        .background(.white)
//        .background(.ultraThinMaterial)
//        .overlay {
//            UnevenRoundedRectangle(
//                topLeadingRadius: 24,
//                bottomLeadingRadius: 55,
//                bottomTrailingRadius: 55,
//                topTrailingRadius: 24,
//                style: .continuous
//            )
//            .stroke(.white.opacity(0.25), lineWidth: 1)
//        }
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 24,
                bottomLeadingRadius: 55,
                bottomTrailingRadius: 55,
                topTrailingRadius: 24,
                style: .continuous
            )
        )
        .ignoresSafeArea(.container, edges: .bottom)
    }
}
