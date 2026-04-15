import SwiftUI

struct PetCard: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    let name: String
    let breedName: String
    let age: Int
    
    var body: some View {
        Button(action: {
            router.push(.pet(.profile))
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
                    
                    Text("Возраст: \(age) года")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
