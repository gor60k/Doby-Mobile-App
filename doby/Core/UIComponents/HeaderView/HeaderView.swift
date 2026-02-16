import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    var titleStyle: TextStyle
    let subtitleStyle: TextStyle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(titleStyle.font)
                .foregroundColor(titleStyle.color)
                
            Text(subtitle)
                .font(subtitleStyle.font)
                .foregroundColor(subtitleStyle.color)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

