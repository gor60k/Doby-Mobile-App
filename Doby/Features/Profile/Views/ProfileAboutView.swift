import SwiftUI

struct ProfileAboutView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    @Environment(DisplayModeService.self) private var displayModeService
    
    let bio: String
    let action: () -> Void
    
    private var emptyViewTitle: String {
        if displayModeService.isOwner {
            return "Расскажите о себе"
        } else {
            return "Пользователь не заполнил описание"
        }
    }
    
    var body: some View {
        Group {
            if bio.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                PrimaryEmptyView(
                    icon: "person.text.rectangle",
                    title: emptyViewTitle,
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
    }
}

#Preview {
    ProfileAboutView(
        bio: "",
        action: {}
    )
    .environment(PrimaryColorService())
    .environment(DisplayModeService(mode: .owner))
}
