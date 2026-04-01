import SwiftUI

struct PrimaryPagination: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    let numberOfPages: Int
    let currentPage: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Capsule()
                    .fill(currentPage == index ? primaryColorService.currentColor.color : Color.secondary)
                    .frame(width: currentPage == index ? 24 : 8, height: 8)
                    .animation(.easeInOut(duration: 0.3), value: currentPage)
            }
        }
    }
}
