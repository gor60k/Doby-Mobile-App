import SwiftUI

struct SettingsPetServicesView: View {
    let action: () -> Void
    
    var body: some View {
        Section("Питомцы и догситтинг") {
            Button(action: { action() }) {
                FormItemRow(title: "Настройки питомцев", icon: "pawprint.fill")
            }
            .buttonStyle(.plain)
            
            Button(action: {}) {
                FormItemRow(title: "Стать догситтером", icon: "figure.walk")
            }
            .buttonStyle(.plain)
        }
    }
}
