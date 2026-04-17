import SwiftUI

struct PetAddingWarningView: View {
    @Binding var warningTagsViewModel: PrimaryTagsViewModel

    var body: some View {
        Section("Особые предупреждения") {
            PrimaryTagsView(
                viewModel: warningTagsViewModel
            )
        }
    }
}
