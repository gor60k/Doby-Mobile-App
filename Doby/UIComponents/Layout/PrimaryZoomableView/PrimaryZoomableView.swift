import SwiftUI

struct PrimaryZoomableView<Content: View>: UIViewRepresentable {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIView(context: Context) -> ZoomView {
        let hosting = UIHostingController(rootView: content)
        
        return ZoomView(contentView: hosting.view)
    }
    
    func updateUIView(_ uiView: ZoomView, context: Context) {}
}
