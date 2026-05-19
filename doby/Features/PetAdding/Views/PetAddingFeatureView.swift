import SwiftUI

struct PetAddingFeatureView: View {
    @Binding var featureTagsViewModel: PrimaryTagsViewModel

    var body: some View {
        Section(
            header: PrimaryFormSectionHeader(title: "Особенности", isRequired: true)
        ) {
            PrimaryTagsView(
                viewModel: featureTagsViewModel
            )
        }
    }
}
