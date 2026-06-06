import SwiftUI

struct PrimaryText: View {
    let text: String
    let style: AppTextStyle
    let isRedacted: Bool
    
    init(
        text: String,
        style: AppTextStyle,
        isRedacted: Bool = false
    ) {
        self.text = text
        self.style = style
        self.isRedacted = isRedacted
    }
    
    var body: some View {
        Text(text)
            .style(style)
            .redacted(reason: isRedacted ? .placeholder : [])
    }
}

#Preview {
    PrimaryText(
        text: "text",
        style: .cardTitle
    )
}
