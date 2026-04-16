import SwiftUI

struct PetAddingFeatureTagsView: View {
    @Binding var featureInput: String
    let featureTags: [String]
    let isAddButtonDisabled: Bool
    let onAdd: () -> Void
    let onDelete: (String) -> Void

    var body: some View {
        PetAddingTagsView(
            title: "Важные предупреждения",
            placeholder: "Например: аллергия",
            input: $featureInput,
            tags: featureTags,
            isAddButtonDisabled: isAddButtonDisabled,
            onAdd: onAdd,
            onDelete: onDelete
        )
    }
}
