import SwiftUI

struct DividerLabel: View {
    let label: String
    
    var body: some View {
        HStack(spacing: 12) {
            Rectangle()
                .fill(Color(.separator))
                .frame(height: 1)
            
            Text(label)
                .font(.system(.footnote, design: .rounded))
                .foregroundStyle(.secondary)
            
            Rectangle()
                .fill(Color(.separator))
                .frame(height: 1)
        }
    }
}
