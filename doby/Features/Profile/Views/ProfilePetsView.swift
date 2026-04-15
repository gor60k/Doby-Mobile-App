import SwiftUI

struct ProfilePetsView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    @State var currentPage: Int = 0
    @State var pets: [Pet]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                PrimarySlider(
                    currentPage: $currentPage,
                    items: pets,
                ) { pet in
                    ProfilePetCardView(
                        id: pet.id,
                        name: pet.name,
                        breedName: pet.breedName,
                        age: pet.age
                    )
                }
                .frame(height: 200)
                
                PrimaryPagination(
                    numberOfPages: pets.count,
                    currentPage: currentPage
                )
            }
            .overlay(alignment: .topTrailing) {
                UtilityButton(
                    action: {
                        router.push(.petAdding)
                    },
                    icon: "plus"
                )
                .padding(.vertical, 16)
                .padding(.trailing, 16)
            }
        }
    }
}
