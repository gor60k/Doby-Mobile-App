import SwiftUI

struct PetAddingTagsView: View {
    @Binding var viewModel: PrimaryTagsViewModel
    let title: String

    var body: some View {
        Section(
            header: PrimaryFormSectionHeader(title: title, isRequired: true)
        ) {
            PrimaryTagsView(
                viewModel: viewModel
            )
        }
    }
}
