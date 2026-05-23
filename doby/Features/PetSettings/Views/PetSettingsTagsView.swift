import SwiftUI

struct PetSettingsTagsView: View {
    @Binding var viewModel: PrimaryTagsViewModel
    
    let title: String
    
    var body: some View {
        Section(title) {
            PrimaryTagsView(viewModel: viewModel)
        }
    }
}
