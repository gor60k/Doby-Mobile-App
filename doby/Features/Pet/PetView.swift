import SwiftUI

struct PetView: View {
    @EnvironmentObject private var router: PetRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    private let viewModel = PetViewModel()

    @State private var isEditing = false
    @State private var selectedPetIDs: Set<Int> = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(viewModel.pets) { pet in
                    HStack {
                        if isEditing {
                            Button(action: {
                                if selectedPetIDs.contains(pet.id) {
                                    selectedPetIDs.remove(pet.id)
                                } else {
                                    selectedPetIDs.insert(pet.id)
                                }
                            }) {
                                Image(systemName: selectedPetIDs.contains(pet.id) ? "checkmark.circle.fill" : "circle")
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
                        if isEditing {
                            selectedPetIDs.removeAll()
                        }
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
            
            ToolbarItem(placement: .bottomBar) {
                if isEditing {
                    Button("Удалить") {
                        // TODO: delete selected pets
                    }
                    .tint(.red)
                }
            }
        }
        .toolbar(isEditing ? .hidden : .visible, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        PetView()
            .withAppEnvironment()
    }
}
