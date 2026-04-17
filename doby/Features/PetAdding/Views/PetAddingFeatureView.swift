import SwiftUI

struct PetAddingFeatureView: View {
    @Binding var featureTagsViewModel: PrimaryTagsViewModel

    var body: some View {
        Section("Особенности") {
            PrimaryTagsView(
                viewModel: featureTagsViewModel
            )
        }
    }
}
