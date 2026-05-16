import SwiftUI

struct ProfileAboutView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    let bio: String

    var body: some View {
        Group {
            if bio.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                emptyState
            } else {
                Text(bio)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }

    private var emptyState: some View {
        VStack(spacing: 14) {
            Image(systemName: "person.text.rectangle")
                .font(.system(size: 42))
                .foregroundStyle(primaryColorService.primaryColor.color)

            VStack(spacing: 6) {
                Text("Расскажите о себе")
                    .font(.headline)

                Text("Добавьте пару слов о себе, интересах или опыте — это поможет другим узнать вас лучше.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            PrimaryButton(
                title: "Заполнить профиль",
                icon: "pencil",
                action: {},
                size: .medium
            )
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileAboutView(bio: "")
        .environment(PrimaryColorService())
}
