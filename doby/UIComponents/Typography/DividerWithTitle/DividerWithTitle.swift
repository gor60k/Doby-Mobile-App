import SwiftUI

struct DividerWithTitle: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .style(AppTextStyle.Presets.captionRegular)
            Divider()
        }
    }
}
