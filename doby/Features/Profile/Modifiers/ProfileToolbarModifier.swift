import SwiftUI

struct ProfileToolbarModifier: ViewModifier {
    let onEditTap: () -> Void
    let onQRScanTap: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Изм.", action: onEditTap)
                    .tint(.primary)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Поделиться", systemImage: "qrcode", action: onQRScanTap)
                    .tint(.primary)
                }
            }
    }
}

extension View {
    func profileToolbar(onEditTap: @escaping () -> Void, onQRScanTap: @escaping () -> Void) -> some View {
        modifier(ProfileToolbarModifier(onEditTap: onEditTap, onQRScanTap: onQRScanTap))
    }
}
