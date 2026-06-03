import SwiftUI

struct PrimaryAvatarPlaceholder: View {
    
    let icon: String
    
    var body: some View {
        Circle()
            .fill(Color.secondary.opacity(0.12))
            .overlay {
                Image(systemName: icon)
                    .font(.system(size: 36))
                    .foregroundColor(.secondary)
            }
    }
}
