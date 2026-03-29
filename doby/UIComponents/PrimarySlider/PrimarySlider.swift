import SwiftUI

struct PrimarySlider<Content: View, Item: Identifiable>: View {
    @Binding var currentPage: Int
    let items: [Item]
    let content: (Item) -> Content
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(items) { item in
                content(item)
                    .tag(item.id)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}
