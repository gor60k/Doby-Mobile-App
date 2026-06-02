import SwiftUI

struct OrdersSitterScreen: View {
    private let sitters: [DogSitter] = [
        .init(
            avatar: "person.crop.circle.fill",
            name: "Анна",
            city: "Москва",
            price: 1800,
            repeatOrders: 12,
            rating: 4.9,
            reviewsCount: 84
        ),
        .init(
            avatar: "person.crop.circle.fill",
            name: "Максим",
            city: "Санкт-Петербург",
            price: 1500,
            repeatOrders: nil,
            rating: 4.8,
            reviewsCount: 51
        ),
        .init(
            avatar: "person.crop.circle.fill",
            name: "Екатерина",
            city: "Казань",
            price: 2200,
            repeatOrders: 27,
            rating: 5.0,
            reviewsCount: 136
        ),
        .init(
            avatar: "person.crop.circle.fill",
            name: "Анна",
            city: "Москва",
            price: 1800,
            repeatOrders: 12,
            rating: 4.9,
            reviewsCount: 84
        ),
        .init(
            avatar: "person.crop.circle.fill",
            name: "Максим",
            city: "Санкт-Петербург",
            price: 1500,
            repeatOrders: nil,
            rating: 4.8,
            reviewsCount: 51
        ),
        .init(
            avatar: "person.crop.circle.fill",
            name: "Екатерина",
            city: "Казань",
            price: 2200,
            repeatOrders: 27,
            rating: 5.0,
            reviewsCount: 136
        )
    ]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(sitters) { sitter in
                    SitterCard(sitter: sitter)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Подходящие догситтеры")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct SitterCard: View {
    let sitter: DogSitter

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 14) {
                Image(systemName: sitter.avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .foregroundStyle(.gray)
//                    .background(
//                        Circle()
//                            .fill(Color.blue.opacity(0.12))
//                            .frame(width: 72, height: 72)
//                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(sitter.name)
                        .font(.headline)

                    Label(sitter.city, systemImage: "mappin.and.ellipse")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(sitter.price) ₽")
                        .font(.title3.weight(.bold))

                    Text("за сутки")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            HStack(spacing: 4) {
                ForEach(0..<5, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                }

                Text(String(format: "%.1f", sitter.rating))
                    .font(.subheadline.weight(.semibold))

                Text("(\(sitter.reviewsCount) отзывов)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            if let repeatOrders = sitter.repeatOrders {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                    Text("Повторных заказов: \(repeatOrders)")
                }
                .font(.subheadline)
                .foregroundStyle(.green)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 10, y: 4)
    }
}

private struct DogSitter: Identifiable {
    let id = UUID()
    let avatar: String
    let name: String
    let city: String
    let price: Int
    let repeatOrders: Int?
    let rating: Double
    let reviewsCount: Int
}

#Preview {
    NavigationStack {
        OrdersSitterScreen()
    }
}
