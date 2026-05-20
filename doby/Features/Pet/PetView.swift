import SwiftUI

struct PetView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    @State var viewModel: PetViewModel
    @State private var isEditing = false
    
    let ownerUUID: String
    
    // MARK: - Функции для переходов к дочерним экранам
    let openPetAdding: () -> Void
    let openPetProfile: (Int) -> Void
    
    init(
        viewModel: PetViewModel,
        ownerUUID: String,
        openPetAdding: @escaping () -> Void,
        openPetProfile: @escaping (Int) -> Void
    ) {
        _viewModel = State(initialValue: viewModel)
        self.ownerUUID = ownerUUID
        self.openPetAdding = openPetAdding
        self.openPetProfile = openPetProfile
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                if viewModel.pets.isEmpty {
                    VStack(alignment: .center) {
                        PrimaryEmptyView(
                            icon: "pawprint.circle.fill",
                            title: "У вас пока нет питомцев",
                            description: "Добавьте своего первого питомца, чтобы начать",
                            buttonTitle: "Добавить питомца",
                            buttonIcon: "plus",
                            action: { openPetAdding() }
                        )
                    }
                } else {
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
                                age: pet.age,
                                openPetProfile: { openPetProfile(pet.id) }
                            )
                        }
                        .animation(.easeInOut, value: isEditing)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Питомцы")
        .navigationBarTitleDisplayMode(.inline)
        .petToolbar(isEditing: $isEditing) {
            openPetAdding()
        }
        .refreshable {
            await viewModel.fetchPets(ownerUUID: ownerUUID)
        }
    }
}

#Preview {
    PetView(
        viewModel: .mock,
        ownerUUID: "",
        openPetAdding: {},
        openPetProfile: { id in }
    )
    .PreviewAppEnvironment()
}
