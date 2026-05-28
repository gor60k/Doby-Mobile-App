import SwiftUI

struct PetProfileAboutView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    let description: String
    let action: () -> Void
    
    var body: some View {
        Group {
            if description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                PrimaryEmptyView(
                    icon: "pawprint.fill",
                    title: "Расскажите о своем питомце",
                    description: "Добавьте пару слов о питомце, его характере и о его особенностях — это поможет другим узнать вашего любимца лучше",
                    buttonTitle: "Заполнить профиль",
                    buttonIcon: "pencil",
                    action: action
                )
            } else {
                Text(description)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
