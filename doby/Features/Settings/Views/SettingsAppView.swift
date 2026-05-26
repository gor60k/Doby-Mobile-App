import SwiftUI

struct SettingsAppView: View {
    let appearanceAction: () -> Void
    let privacyAction: () -> Void
    let notificationsAction: () -> Void
    
    var body: some View {
        Section("Приложение") {
            Button(action: { appearanceAction() }) {
                FormItemRow(title: "Оформление", icon: "paintbrush.fill")
            }
            .buttonStyle(.plain)
            
            Button(action: { privacyAction() }) {
                FormItemRow(title: "Безопасность", icon: "lock.fill")
            }
            .buttonStyle(.plain)
            
            Button(action: { notificationsAction() }) {
                FormItemRow(title: "Уведомления", icon: "bell.badge.fill")
            }
            .buttonStyle(.plain)
        }
    }
}
