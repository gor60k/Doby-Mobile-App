import SwiftUI

struct PrimaryCollapsibleSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    @State private var isExpanded = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            DisclosureGroup(isExpanded: $isExpanded) {
                content()
            } label: {
                DividerWithTitle(title: title)
                    .contentShape(Rectangle())
            }
            .disclosureGroupStyle(PlainDisclosureGroupStyle())
        }
    }
}

struct PlainDisclosureGroupStyle: DisclosureGroupStyle {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    var chevronIcon: String = "chevron.up"
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            withAnimation {
                configuration.isExpanded.toggle()
            }
        }) {
            HStack {
                configuration.label
                Spacer()
                Image(systemName: chevronIcon)
                    .foregroundColor(primaryColorService.currentColor.color)
                    .rotationEffect(.degrees(configuration.isExpanded ? 180 : 90))
                    .animation(.easeInOut(duration: 0.2), value: configuration.isExpanded)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)

        if configuration.isExpanded {
            configuration.content
        }
    }
}
