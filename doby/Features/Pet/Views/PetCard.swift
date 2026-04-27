import SwiftUI

struct PetCard: View {
    @EnvironmentObject private var router: PetRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    let id: Int
    let name: String
    let breedName: String
    let age: Int
    
    var body: some View {
        Button(action: {
            router.push(.profile(id: id))
        }) {
            HStack(spacing: 12) {
                Image(systemName: "pawprint.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(primaryColorService.currentColor.color)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.headline)
                    
                    Text("Порода: \(breedName)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(age.yearsString)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.primary.opacity(0.06), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
