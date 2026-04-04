import SwiftUI

struct PrimaryFeedback: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 12) {
                Image("ProfileAvatarPlaceholder")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.black.opacity(0.06), lineWidth: 1)
                    )
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .center) {
                        Text("42 БОСС")
                            .style(AppTextStyle.Presets.bodyBold)
                        
                        Spacer(minLength: 8)
                        
                        Text("01.04.2026, 14:00")
                            .style(AppTextStyle.Presets.footnoteRegular)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 4) {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
            
            Text("Я осталась в полном восторге :) это была первая передержка для нашей Лоры за 13 лет, и всё прошло супер! Ирина каждые несколько часов первого дня кидала фото и видео, чтобы мне было спокойнее. Потом был ежедневный фотоотчет. Ирина всегда была на связи. Когда забирали собачку было видно, что Ирина ей очень полюбилась :) на радостях не знала к кому бежать, к нам или к ней. Очень и очень довольна. Рекомендую Обязательно обратимся ещё раз именно к Ирине")
                .style(AppTextStyle.Presets.bodySemibold)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        )
    }
}

#Preview {
    VStack {
        PrimaryFeedback()
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .background(Color(.systemGroupedBackground))
}
