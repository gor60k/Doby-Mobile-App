import SwiftUI

struct OrdersChooseScreen: View {
    
    let openSitters: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Выберите услугу")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)

                    Text("Найдите заботливого помощника для вашего питомца")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                .padding(.top, 12)

                VStack(spacing: 16) {
                    ServiceCard(
                        title: "Передержка",
                        subtitle: "Питомец живёт у ситтера дома",
                        icon: "house.fill",
                        gradient: [.primaryYellowLight, .primaryYellow],
                        openSitters: openSitters
                    )

                    ServiceCard(
                        title: "Выгул",
                        subtitle: "Активные прогулки в удобное время",
                        icon: "figure.walk",
                        gradient: [.primaryBlueLight, .primaryBlue],
                        openSitters: openSitters
                    )

                    ServiceCard(
                        title: "Визиты",
                        subtitle: "Кормление, уход и внимание у вас дома",
                        icon: "heart.text.square.fill",
                        gradient: [.primaryGreenLight, .primaryGreen],
                        openSitters: openSitters
                    )
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 24)
        }
        .background(Color(.systemGroupedBackground))
    }
}

private struct ServiceCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let gradient: [Color]
    
    let openSitters: () -> Void

    var body: some View {
        Button(action: { openSitters() }) {
            HStack(spacing: 16) {
                ZStack {
                    LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)

                    Image(systemName: icon)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.title3.bold())
                        .foregroundStyle(.primary)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.headline)
                    .foregroundStyle(.tertiary)
            }
            .padding(18)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 6)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    OrdersChooseScreen(
        openSitters: {}
    )
}
