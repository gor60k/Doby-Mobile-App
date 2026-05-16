import SwiftUI

struct PetView: View {
    @Environment(\.petStorage) private var storage
    @Environment(PetRouter.self) private var router
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    @State var viewModel: PetViewModel
    @State private var isEditing = false
    
    let ownerUUID: String
    
    init(
        repository: PetRepositoryProtocol,
        ownerUUID: String
    ) {
        _viewModel = State(initialValue: PetViewModel(repository: repository))
        self.ownerUUID = ownerUUID
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(viewModel.pets) { pet in
                    HStack {
                        if isEditing {
                            Button(role: .destructive) {
                                Task {
                                    await viewModel.deletePet(id: pet.id)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                            .transition(.move(edge: .leading).combined(with: .opacity))
                        }
                        
                        PetCard(
                            id: pet.id,
                            imageURL: pet.photos.first?.imageURL,
                            name: pet.name,
                            breedName: pet.breedName,
                            age: pet.age
                        )
                    }
                    .animation(.easeInOut, value: isEditing)
                }
            }
            .padding()
        }
        .navigationTitle("Питомцы")
        .navigationBarTitleDisplayMode(.inline)
        .petToolbar(isEditing: $isEditing) {
            router.push(.petAdding)
        }
        .refreshable {
            await viewModel.fetchPets(ownerUUID: ownerUUID)
        }
    }
}
