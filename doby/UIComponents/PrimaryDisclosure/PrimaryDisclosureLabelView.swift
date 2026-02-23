import SwiftUI

struct PrimaryDisclosureLabelView: View {
    let title: String
    let icon: String?
    
    var body: some View {
        HStack {
            if let icon {
                Image(systemName: icon)
                    .font(.title3)
            }
            Text(title)
                .style(AppTextStyle.Presets.headlineBold)
        }
    }
}

