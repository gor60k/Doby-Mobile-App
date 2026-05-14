import SwiftUI

struct PetToolbarModifier: ViewModifier {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    @Binding var isEditing: Bool
    let onAddTap: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isEditing ? "Готово" : "Изм.") {
                        withAnimation(.easeInOut) {
                            isEditing.toggle()
                        }
                    }
                    .tint(.primary)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    if !isEditing {
                        Button("Добавить", systemImage: "plus", action: onAddTap)
                            .tint(primaryColorService.primaryColor.color)
                    }
                }
            }
    }
}

extension View {
    func petToolbar(
        isEditing: Binding<Bool>,
        onAddTap: @escaping () -> Void
    ) -> some View {
        modifier(
            PetToolbarModifier(
                isEditing: isEditing,
                onAddTap: onAddTap
            )
        )
    }
}
