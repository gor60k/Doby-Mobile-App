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
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    Form {
        PetAddingSubmitView(
            addPet: {},
            isLoading: false
        )
    }
}
