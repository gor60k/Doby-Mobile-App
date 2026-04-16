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
                tagFlow(tags)
            }
        }
    }

    private func tagFlow(_ tags: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(tags, id: \.self) { tag in
                HStack(spacing: 8) {
                    Text(tag)
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Capsule())

                    Button(role: .destructive) {
                        onDelete(tag)
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .buttonStyle(.plain)

                    Spacer(minLength: 0)
                }
            }
        }
    }
}
