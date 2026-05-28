import SwiftUI

struct PrimarySlider<Content: View, Item: Identifiable>: View {
    @Binding var currentPage: Int
    let items: [Item]
    let content: (Item) -> Content

    @State private var pageHeights: [Int: CGFloat] = [:]
    private var maxPageHeight: CGFloat? {
        pageHeights.values.max()
    }

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                content(item)
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .preference(
                                    key: PrimarySliderHeightPreferenceKey.self,
                                    value: [index: proxy.size.height]
                                )
                        }
                    }
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: maxPageHeight)
        .onPreferenceChange(PrimarySliderHeightPreferenceKey.self) { heights in
            pageHeights.merge(heights) { current, new in
                max(current, new)
            }
        }
    }
}

private struct PrimarySliderHeightPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]

    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue()) { _, new in new }
    }
}
