import SwiftUI

struct ProfileOrderCardView: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(order.serviceText)
                        .style(AppTextStyle.Presets.bodySemibold)
                    
                    Text("Питомец: \(order.petName)")
                        .style(AppTextStyle.Presets.captionRegular)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Text(order.statusText)
                    .style(AppTextStyle.Presets.captionRegular)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(primaryColorService.currentColor.color.opacity(0.12), in: Capsule())
            }
            
            VStack(alignment: .leading, spacing: 10) {
                OrderHistoryInfoRow(
                    icon: "person.fill",
                    title: "Исполнитель",
                    value: order.executorName
                )
                
                OrderHistoryInfoRow(
                    icon: "calendar",
                    title: "Дата",
                    value: order.dateText
                )
                
                OrderHistoryInfoRow(
                    icon: "clock",
                    title: "Время",
                    value: order.timeText
                )
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: 1)
        )
    }
}

struct OrderHistoryInfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .frame(width: 18)
                .foregroundStyle(.secondary)
            
            Text(title)
                .style(AppTextStyle.Presets.captionRegular)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Text(value)
                .style(AppTextStyle.Presets.bodyRegular)
                .multilineTextAlignment(.trailing)
        }
    }
}
