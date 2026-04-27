import SwiftUI

struct PetView: View {
    @EnvironmentObject private var router: PetRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    private let viewModel = PetViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(viewModel.pets) { pet in
                    PetCard(
                        id: pet.id,
                        name: pet.name,
                        breedName: pet.breedName,
                        age: pet.age
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Питомцы")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Изм.", action: {})
                    .tint(.primary)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Добавить", systemImage: "plus", action: {
                    router.push(.petAdding)
                })
                    .tint(primaryColorService.primaryColor.color)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PetView()
            .withAppEnvironment()
    }
}
