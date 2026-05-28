import SwiftUI

struct PetProfileToolbarModifier: ViewModifier {
    let onEdit: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Изм.", action: onEdit)
                        .tint(.primary)
                }
            }
    }
}

extension View {
    func petProfileToolbar(onEdit: @escaping () -> Void) -> some View {
        modifier(PetProfileToolbarModifier(onEdit: onEdit))
    }
}
