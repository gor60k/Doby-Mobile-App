import SwiftUI

struct PrimaryGalleryPagination: View {
    let currentPage: Int
    let itemsCount: Int
    
    var body: some View {
        Text("\(currentPage + 1) / \(itemsCount)")
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.black.opacity(0.5))
            .clipShape(Capsule())
//        HStack {
//            
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
//        .padding(.horizontal)
//        .padding(.bottom, 24)
    }
}
