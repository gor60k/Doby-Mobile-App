import SwiftUI

struct PetProfileInfoCardView: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    let item: PetProfileInfoItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
            Text(item.formattedVale)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(primaryColorService.currentColor.color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16).fill(primaryColorService.currentColor.color.opacity(0.1))
        )
    }
}
