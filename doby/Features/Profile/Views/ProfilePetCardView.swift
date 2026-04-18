import SwiftUI

struct ProfilePetCardView: View {
    @EnvironmentObject var router: ProfileRouter
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    let id: Int
    let name: String
    let breedName: String
    let age: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack {
                Image(systemName: "pawprint.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(primaryColorService.currentColor.color)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                    .foregroundColor(primaryColorService.currentColor.color)

                Text(breedName)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)

                HStack(spacing: 12) {
                    Label(age.yearsString, systemImage: "calendar")
                    Label("Мальчик", systemImage: "pawprint")
                }
                .font(.caption)
                .foregroundColor(.secondary)

                Divider()
                    .padding(.vertical, 4)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Обо мне")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.secondary)

                    Text("Дружелюбный и энергичный, люблю грызть тапки")
                        .font(.system(.footnote, design: .rounded))
                        .foregroundColor(.primary)
                        .lineLimit(3)
                }
                
                Spacer()
                
                Button(action: {
                    router.push(.petProfile(petId: id))
                }) {
                    Text("Подробнее")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.white)
                        
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(RoundedRectangle(cornerRadius: 12).fill(primaryColorService.currentColor.color))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(primaryColorService.currentColor.color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    VStack {
        ProfilePetCardView(
            id: 0,
            name: "pet.name",
            breedName: "pet.breedName",
            age: 0
        )
    }
    .withAppEnvironment()
    .padding()
}
