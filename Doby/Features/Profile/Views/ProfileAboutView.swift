import SwiftUI

struct ProfileAboutView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    @Environment(ViewContextService.self) private var viewContextService
    
    let bio: String
    let action: () -> Void
    
    private var emptyViewTitle: String {
        if viewContextService.isCurrentUser {
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
}
