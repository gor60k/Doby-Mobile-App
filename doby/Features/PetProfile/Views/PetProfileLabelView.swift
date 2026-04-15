import SwiftUI

struct PetProfileLabelView: View {
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    let name: String
    let species: String
    let age: Int
    let gender: Gender
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack {
                    Text(species)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text("\(age.yearsString)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Text(gender == .male ? "♂" : "♀")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 12).fill(primaryColorService.currentColor.color))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .glassEffect(
            .regular
                .tint(primaryColorService.currentColor.color.opacity(0.1)),
            in: RoundedRectangle(cornerRadius: 16)
        )
        .padding(.horizontal, 16)
        .offset(y: -16)
        .zIndex(1)
    }
}
