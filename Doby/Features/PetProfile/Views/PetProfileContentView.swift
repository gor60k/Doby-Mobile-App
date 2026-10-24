import SwiftUI

struct PetProfileContentView: View {
    let pet: Pet
    @Binding var currentPage: Int
    let infoItems: [PetProfileInfoItem]
    @Binding var selection: PetProfileScreen.PetDetailsTab
    let options: [PetProfileScreen.PetDetailsTab]
    
    var body: some View {
        VStack(spacing: 0) {
            PetProfileGallaryView(
                currentPage: $currentPage,
                items: pet.photos
            )
            
            PetProfileLabelView(
                name: pet.name,
                species: pet.breedName,
                age: pet.age,
                gender: pet.gender
            )
            
            PrimaryCollapsibleSection(title: "Подробнее") {
                VStack(spacing: 10) {
                    HStack(spacing: 8) {
                        ForEach(Array(infoItems.enumerated()), id: \.offset) { _, item in
                            PetProfileInfoCardView(item: item)
                        }
                    }
                    
                    PetProfileDetailsView(
                        selection: $selection,
                        aboutValue: .about,
                        feedbackValue: .feedback,
                        options: options,
                        title: { $0.rawValue },
                        description: pet.additionalInfo,
                        buttonAction: {}
                    )
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            PrimaryCollapsibleSection(title: "Мои особенности") {
                PetProfileTagsView(tags: pet.specificTags)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            PrimaryCollapsibleSection(title: "Что я ем") {
                PetProfileDietView(
                    dietType: pet.dietType,
                    dietPatterns: pet.dietPatterns,
                    dietAdditionalInfo: pet.dietAdditionalInfo
                )
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            PrimaryCollapsibleSection(title: "Важные предупреждения!") {
                PetProfileTagsView(tags: pet.warningTags)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
    }
}
