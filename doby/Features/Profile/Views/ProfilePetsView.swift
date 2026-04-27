import SwiftUI

struct ProfilePetsView: View {
    @EnvironmentObject private var router: ProfileRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    @State var currentPage: Int = 0
    @State var pets: [Pet]
    
    var body: some View {
        if pets.isEmpty {
            VStack(spacing: 16) {
                Spacer()
                
                Image(systemName: "pawprint.circle.fill")
                    .font(.system(size: 64))
                    .foregroundColor(primaryColorService.primaryColor.color)
                
                VStack(spacing: 8) {
                    Text("У вас пока нет питомцев")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Добавьте своего первого питомца, чтобы начать")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                
                PrimaryButton(
                    title: "Добавить питомца",
                    icon: "plus",
                    action: {
                        router.push(.petAdding)
                    },
                    size: .medium
                )
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
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
}

#Preview {
    ProfilePetsView(currentPage: 0, pets: [])
        .withAppEnvironment()
}
