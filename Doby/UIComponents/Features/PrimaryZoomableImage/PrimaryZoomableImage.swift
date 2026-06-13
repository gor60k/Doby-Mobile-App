import SwiftUI
import UIKit
import Kingfisher

struct PrimaryZoomableImage: View {
    let url: URL?
    let isPreview = false
    
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 1
    
    var body: some View {
        if isPreview {
            Image("MockUserIcon")
                .resizable()
                .scaledToFit()
        } else {
            KFImage(url)
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            scale = lastScale * value.magnification
                        }
                        .onEnded { _ in
                            lastScale = scale
                        }
                )
        }
    }
}
