import SwiftUI

struct PrimaryFeedback: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image("ProfileAvatarPlaceholder")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("42 БОСС")
                        .style(AppTextStyle.Presets.bodyBold)
                    
                    HStack {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
            
            VStack {
                Text("Я осталась в полном восторге :) это была первая передержка для нашей Лоры за 13 лет, и всё прошло супер! Ирина каждые несколько часов первого дня кидала фото и видео, чтобы мне было спокойнее. Потом был ежедневный фотоотчет. Ирина всегда была на связи. Когда забирали собачку было видно, что Ирина ей очень полюбилась :) на радостях не знала к кому бежать, к нам или к ней. Очень и очень довольна. Рекомендую Обязательно обратимся ещё раз именно к Ирине")
                    .style(AppTextStyle.Presets.bodySemibold)
            }
            
            Text("01.04.2026, 14:00")
                .style(AppTextStyle.Presets.footnoteRegular)
            
            Divider()
        }
    }
}

#Preview {
    PrimaryFeedback()
}
