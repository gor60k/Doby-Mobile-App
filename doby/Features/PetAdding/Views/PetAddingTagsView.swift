import SwiftUI

struct PetAddingTagsView: View {
    let title: String
    let placeholder: String
    @Binding var input: String
    let tags: [String]
    let isAddButtonDisabled: Bool
    let onAdd: () -> Void
    let onDelete: (String) -> Void

    var body: some View {
        Section(title) {
            HStack(spacing: 8) {
                TextField(placeholder, text: $input)
                    .textInputAutocapitalization(.sentences)

                Button("Добавить") {
                    onAdd()
                }
                .disabled(isAddButtonDisabled)
            }

            if !tags.isEmpty {
                TagFlow(tags: tags, onDelete: onDelete)
            }
        }
    }
}
