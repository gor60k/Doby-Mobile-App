import SwiftUI

struct PetAddingWarningTagsView: View {
    @Binding var warningInput: String
    let warningTags: [String]
    let isAddButtonDisabled: Bool
    let onAdd: () -> Void
    let onDelete: (String) -> Void

    var body: some View {
        PetAddingTagsView(
            title: "Важные предупреждения",
            placeholder: "Например: аллергия",
            input: $warningInput,
            tags: warningTags,
            isAddButtonDisabled: isAddButtonDisabled,
            onAdd: onAdd,
            onDelete: onDelete
        )
    }
}
