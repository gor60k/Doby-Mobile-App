import SwiftUI

struct PetView: View {
    @EnvironmentObject private var router: PetRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    @State private var viewModel = PetViewModel(repository: PetRepository())

    @State private var isEditing = false
    
    let ownerUUID: String
    
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "Готово" : "Изм.") {
                    withAnimation(.easeInOut) {
                        isEditing.toggle()
                    }
                }
                .tint(.primary)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                if !isEditing {
                    Button("Добавить", systemImage: "plus") {
                        router.push(.petAdding)
                    }
                    .tint(primaryColorService.primaryColor.color)
                }
            }
        }
        .refreshable {
            await viewModel.fetchPets(ownerUUID: ownerUUID)
        }
        .task {
            await viewModel.fetchPets(ownerUUID: ownerUUID)
        }
    }
}

#Preview {
    NavigationStack {
        PetView(ownerUUID: "")
            .withAppEnvironment()
    }
}
