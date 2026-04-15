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
                        name: pet.name,
                        breedName: pet.breedName,
                        age: pet.age
                    )
                }
            }
            .padding()
            
            UtilityButton(
                action: {
                    router.push(.petAdding)
                },
                icon: "plus"
            )
        }
    }
}

#Preview {
    PetView()
        .withAppEnvironment()
}
