import SwiftUI

struct PetProfileLabelView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
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
                .background(RoundedRectangle(cornerRadius: 12).fill(primaryColorService.primaryColor.color))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .glassEffect(
            .regular
                .tint(primaryColorService.primaryColor.color.opacity(0.1)),
            in: RoundedRectangle(cornerRadius: 16)
        )
        .padding(.horizontal, 16)
        .offset(y: -16)
        .zIndex(1)
    }
}
