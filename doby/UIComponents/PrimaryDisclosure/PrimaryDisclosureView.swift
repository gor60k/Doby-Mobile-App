import SwiftUI

struct PrimaryDisclosureView<Content: View>: View {
    @State private var isExpanded: Bool = false
    
    let title: String
    let headlineIcon: String?
    let description: String
    let content: Content
    
    init(
        title: String,
        headlineIcon: String? = nil,
        description: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.headlineIcon = headlineIcon
        self.description = description
        self.content = content()
    }
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            Text(description)
                .style(AppTextStyle.Presets.bodyRegular)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                content
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        } label: {
            PrimaryDisclosureLabelView(
                title: title,
                icon: headlineIcon
            )
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack {
            PrimaryDisclosureView(
                title: "title",
                headlineIcon: "dog.fill",
                description: "description",
                content: {
                    Button("Action") {}
                        .buttonStyle(.borderedProminent)
                }
            )
            .glassEffect(
                .regular.tint(.white).interactive(),
                in: RoundedRectangle(cornerRadius: 16)
            )
        }
        .padding()
    }
}
