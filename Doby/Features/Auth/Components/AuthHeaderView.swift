import SwiftUI

struct AuthHeaderView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            PrimaryText(
                text: title,
                style: .subtitle
            )
            
            PrimaryText(
                text: subtitle,
                style: .secondaryContent
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 24)
    }
}
