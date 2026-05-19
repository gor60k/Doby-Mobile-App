import SwiftUI

struct PetAddingWarningView: View {
    @Binding var warningTagsViewModel: PrimaryTagsViewModel

    var body: some View {
        Section(
            header: PrimaryFormSectionHeader(title: "Особые предупреждения", isRequired: true)
        ) {
            PrimaryTagsView(
                viewModel: warningTagsViewModel
            )
        }
    }
}
