import SwiftUI

struct SettingsToolbarModifier: ViewModifier {
    let onSave: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Готово", action: {
                        onSave()
                    })
                    .tint(.primary)
                }
            }
    }
}

extension View {
    func settingsToolbar(onSave: @escaping () -> Void) -> some View {
        modifier(SettingsToolbarModifier(onSave: onSave))
    }
}
