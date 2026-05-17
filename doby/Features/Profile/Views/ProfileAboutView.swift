import SwiftUI

struct ProfileAboutView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    let bio: String
    let action: () -> Void

    var body: some View {
        Group {
            if bio.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                PrimaryEmptyView(
                    icon: "person.text.rectangle",
                    title: "Расскажите о себе",
                    description: "Добавьте пару слов о себе, интересах или опыте — это поможет другим узнать вас лучше.",
                    buttonTitle: "Заполнить профиль",
                    buttonIcon: "pencil",
                    action: action
                )
            } else {
                Text(bio)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
//        .padding()
    }
}

#Preview {
    ProfileAboutView(bio: "", action: {})
        .environment(PrimaryColorService())
}
