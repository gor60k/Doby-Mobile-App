import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String?
    var titleStyle: AppTextStyle
    let subtitleStyle: AppTextStyle?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(titleStyle.font)
                .foregroundColor(titleStyle.color)
                
            if let subtitle = subtitle {
                Text(subtitle)
                    .font((subtitleStyle ?? AppTextStyle.Presets.subheadlineRegular).font)
                    .foregroundColor((subtitleStyle ?? AppTextStyle.Presets.subheadlineRegular).color)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

