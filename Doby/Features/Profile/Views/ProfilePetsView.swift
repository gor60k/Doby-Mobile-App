import SwiftUI

struct ProfilePetsView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    @Environment(ViewContextService.self) private var viewContextService
    
    @State var currentPage: Int = 0
    
    let pets: [Pet]
    
    // MARK: - Функции для перехода на дочерние экраны
    let openPetAdding: () -> Void
    let openPetProfile: (Int) -> Void
    
    private var emptyViewTitle: String {
        if viewContextService.isCurrentUser {
            return "Вы пока не добавили ни одного питомца"
        } else {
            return "Пользователь пока не добавил ни одного питомца"
        }
    }
    
    var body: some View {
        if pets.isEmpty {
            PrimaryEmptyView(
                icon: "pawprint.circle.fill",
                title: emptyViewTitle,
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
                                description: pet.additionalInfo,
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
                    if viewContextService.isCurrentUser {
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
}
