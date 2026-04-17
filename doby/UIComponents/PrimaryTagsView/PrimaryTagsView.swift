import SwiftUI
import Observation

struct PrimaryTagsView: View {
    @Bindable var viewModel: PrimaryTagsViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                TextField(viewModel.placeholder, text: $viewModel.input)
                    .textInputAutocapitalization(.sentences)

                Button("Добавить") {
                    viewModel.addTag()
                }
                .disabled(viewModel.isAddButtonDisabled)
            }

            if !viewModel.tags.isEmpty {
                TagFlow(
                    tags: viewModel.tags,
                    onDelete: viewModel.removeTag
                )
            }
        }
    }
}
