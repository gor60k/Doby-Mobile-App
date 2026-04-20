import SwiftUI

struct OrdersToolbarModifier: ViewModifier {
    let onEditTap: () -> Void
    let onAddTap: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Изм.", action: onEditTap)
                    .tint(.primary)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Новый заказ", systemImage: "plus", action: onAddTap)
                    .tint(.primary)
                }
            }
    }
}

extension View {
    func ordersToolbar(
        onEditTap: @escaping () -> Void,
        onAddTap: @escaping () -> Void
    ) -> some View {
        self.modifier(OrdersToolbarModifier(
            onEditTap: onEditTap,
            onAddTap: onAddTap
        ))
    }
}
