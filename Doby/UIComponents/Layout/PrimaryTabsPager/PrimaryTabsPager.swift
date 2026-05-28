import SwiftUI

struct PrimaryTabsPager<Content: View>: View {
    @Binding var selectedIndex: Int
    let pageCount: Int
    let content: Content
    
    init(
        selectedIndex: Binding<Int>,
        pageCount: Int,
        @ViewBuilder content: () -> Content
    ) {
        self._selectedIndex = selectedIndex
        self.pageCount = pageCount
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                content
                    .frame(width: geometry.size.width)
            }
            .offset(x: -CGFloat(selectedIndex) * geometry.size.width)
            .animation(.easeInOut, value: selectedIndex)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold = geometry.size.width / 3
                        if value.translation.width < -threshold && selectedIndex < 2 {
                            selectedIndex += 1
                        } else if value.translation.width > threshold && selectedIndex > 0 {
                            selectedIndex -= 1
                        }
                    }
            )
        }
    }
}
