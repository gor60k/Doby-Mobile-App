import SwiftUI

struct PetAddingSubmitView: View {
    let addPet: () -> Void
    let isLoading: Bool
    
    var body: some View {
        Section {
            Button {
                addPet()
            } label: {
                HStack {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Добавить питомца")
                            .fontWeight(.semibold)
                    }
                }
            }
//            .disabled(viewModel.isLoading || viewModel.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }
}
