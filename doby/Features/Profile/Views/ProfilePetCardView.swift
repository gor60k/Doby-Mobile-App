import SwiftUI

struct ProfilePetCardView: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image("PetAvatarPlaceholder")
                .resizable()
                .frame(height: 200)
            
            VStack(alignment: .leading) {
                Text("Бобик")
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                    .foregroundColor(primaryColorService.currentColor.color)

                Text("Такса")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)

                HStack(spacing: 12) {
                    Label("2 года", systemImage: "calendar")
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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(primaryColorService.currentColor.color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    VStack {
        ProfilePetCardView()
    }
    .withAppEnvironment()
    .padding()
}
