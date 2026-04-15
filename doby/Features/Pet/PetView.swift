import SwiftUI

struct PetView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    private let petStorage = PetStorage.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(petStorage.pets) { pet in
                    PetCard(
                        id: pet.id,
                        name: pet.name,
                        breedName: pet.breedName,
                        age: pet.age
                    )
                }
            }
            .padding()
            
            Button(action: {
                router.push(.petAdding)
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 30))
                    .foregroundColor(primaryColorService.currentColor.color)
            }
            .padding()
            .glassEffect(
                .regular
                    .tint(primaryColorService.currentColor.color.opacity(0.1))
                    .interactive(),
            )
            .clipShape(.circle)
        }
    }
}

#Preview {
    PetView()
        .withAppEnvironment()
}
