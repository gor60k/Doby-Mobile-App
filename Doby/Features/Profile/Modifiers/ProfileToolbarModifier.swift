import SwiftUI

struct ProfileToolbarModifier: ViewModifier {
    @Environment(ViewContextService.self) private var viewContextService
    
    let onEditTap: () -> Void
    let onQRScanTap: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                if viewContextService.isCurrentUser {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Изм.", action: onEditTap)
                        .tint(.primary)
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Поделиться", systemImage: "qrcode", action: onQRScanTap)
                        .tint(.primary)
                    }
                } else {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Поделиться", systemImage: "qrcode", action: onQRScanTap)
                        .tint(.primary)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Написать", systemImage: "message", action: {})
                            .tint(.primary)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button("Пожаловаться", systemImage: "flag") {
                                // report
                            }

                            Button("Скрыть пользователя", systemImage: "eye.slash") {
                                // hide
                            }

                            Button("Заблокировать", systemImage: "hand.raised") {
                                // block
                            }

                            Divider()

                            Button("Поделиться профилем", systemImage: "square.and.arrow.up") {
                                // share
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                    }
                }
            }
    }
}

extension View {
    func profileToolbar(
        onEditTap: @escaping () -> Void,
        onQRScanTap: @escaping () -> Void
    ) -> some View {
        modifier(ProfileToolbarModifier(
            onEditTap: onEditTap,
            onQRScanTap: onQRScanTap
        ))
    }
}
