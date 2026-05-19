import SwiftUI

struct ProfilePetsView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    @State var currentPage: Int = 0
    
    let pets: [Pet]
    
    // MARK: - Функции для перехода на дочерние экраны
    let openPetAdding: () -> Void
    let openPetProfile: (Int) -> Void
    
    var body: some View {
        if pets.isEmpty {
            PrimaryEmptyView(
                icon: "pawprint.circle.fill",
                title: "У вас пока нет питомцев",
                description: "Добавьте своего первого питомца, чтобы начать",
                buttonTitle: "Добавить питомца",
                buttonIcon: "plus",
                action: { openPetAdding() }
            )
        } else {
            ZStack(alignment: .topTrailing) {
                VStack {
                    VStack {
                        PrimarySlider(
                            currentPage: $currentPage,
                            items: pets,
                        ) { pet in
                            ProfilePetCardView(
                                id: pet.id,
                                imageURL: pet.photos.first?.imageURL,
                                name: pet.name,
                                breedName: pet.breedName,
                                age: pet.age,
                                openPetProfile: { id in
                                    openPetProfile(id)
                                }
                            )
                        }
                        .frame(height: 200)
                        
                        PrimaryPagination(
                            numberOfPages: pets.count,
                            currentPage: currentPage
                        )
                    }
                }
                .overlay(alignment: .topTrailing) {
                    UtilityButton(
                        action: { openPetAdding() },
                        icon: "plus"
                    )
                    .padding(.vertical, 16)
                    .padding(.trailing, 16)
                }
            }
        }
    }
}
