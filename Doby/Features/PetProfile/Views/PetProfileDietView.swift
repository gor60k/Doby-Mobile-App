import SwiftUI

struct PetProfileDietView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    let dietType: String
    let dietPatterns: String
    let dietAdditionalInfo: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            profileSection(
                title: "Тип питания",
                icon: "fork.knife",
                value: dietType
            )
            
            profileSection(
                title: "Пищевые привычки",
                icon: "leaf",
                value: dietPatterns
            )
            
            profileSection(
                title: "Дополнительная информация",
                icon: "info.circle",
                value: dietAdditionalInfo
            )
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(primaryColorService.primaryColor.color.opacity(0.1)))
        )
    }
    
    @ViewBuilder
    private func profileSection(title: String, icon: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(primaryColorService.primaryColor.color)
                
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.secondary)
            }
            
            Text(value.isEmpty ? "Не указано" : value)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.primary)
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color(.systemBackground))
                )
        }
    }
}
