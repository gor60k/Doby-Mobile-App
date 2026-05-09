import SwiftUI

struct PrimaryPagination: View {
    @Environment(PrimaryColorService.self) var primaryColorService
    
    let numberOfPages: Int
    let currentPage: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Capsule()
                    .fill(currentPage == index ? primaryColorService.primaryColor.color : Color(.secondarySystemBackground))
                    .frame(width: currentPage == index ? 24 : 8, height: 8)
                    .animation(.easeInOut(duration: 0.3), value: currentPage)
            }
        }
    }
}
 
