import SwiftUI

struct RoleAccordionView<Content: View>: View {
    let item: RoleAccordionItem
    let content: Content
    
    @State private var isExpanded: Bool = false
    
    init(item: RoleAccordionItem, @ViewBuilder content: () -> Content) {
        self.item = item
        self.content = content()
    }
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 16) {
                Text(item.description)
                    .style(AppTextStyle.Presets.bodyRegular)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                content
            }
            .padding(.top, 8)
        } label: {
            headerLabel
        }
        .padding()
        .glassEffect(
            .regular.tint(item.bgColor).interactive(),
            in: RoundedRectangle(cornerRadius: 16)
        )
        .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isExpanded)
    }
    
    private var headerLabel: some View {
        HStack(spacing: 12) {
            Image(systemName: item.systemImage)
                .font(.title3)
                .foregroundColor(.primaryYellow)
                .frame(width: 32)
            
            Text(item.title)
                .style(AppTextStyle.Presets.headlineBold)
            
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        RoleAccordionView(item: RoleAccordionItem(
            title: "Я Догситтер!",
            description: "Описание роли догситтера в несколько строк для проверки верстки.",
            systemImage: "pet.carrier.fill",
            roleValue: .sitter,
            bgColor: .yellow.opacity(0.2)
        )) {
            Button("Action") {}
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
