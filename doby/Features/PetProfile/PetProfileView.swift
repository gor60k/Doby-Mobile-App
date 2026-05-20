import SwiftUI

struct PetProfileView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    @State private var viewModel: PetProfileViewModel
    let petId: Int
    
    // MARK: - Функции для перехода к дочерним экранам
    let openSettings: (Int) -> Void
    
    init(
        viewModel: PetProfileViewModel,
        petId: Int,
        openSettings: @escaping (Int) -> Void
    ) {
        self.petId = petId
        self.openSettings = openSettings
        
        _viewModel = State(initialValue: viewModel)
    }
    
    enum PetDetailsTab: String, CaseIterable {
        case about = "Обо мне"
        case feedback = "Отзывы"
    }
    
    @State private var selection: PetDetailsTab = .about
    let options: [PetDetailsTab] = PetDetailsTab.allCases
    
    let grid = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                PetProfileGallaryView(
                    currentPage: $viewModel.currentPage,
                    items: viewModel.slides
                )
                
                PetProfileLabelView(
                    name: viewModel.pet?.name ?? "",
                    species: viewModel.pet?.breedName ?? "",
                    age: viewModel.pet?.age ?? 0,
                    gender: .male
                )
                
                PrimaryCollapsibleSection(title: "Подробнее") {
                    VStack(spacing: 10) {
                        HStack(spacing: 8) {
                            ForEach(Array(viewModel.infoItems.enumerated()), id: \.offset) { _, item in
                                PetProfileInfoCardView(item: item)
                            }
                        }
                        
                        PetProfileDetailsView(
                            selection: $selection,
                            aboutValue: .about,
                            feedbackValue: .feedback,
                            options: options,
                            title: { $0.rawValue },
                            description: viewModel.petDescription,
                            buttonAction: {}
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                PrimaryCollapsibleSection(title: "Мои особенности") {
                    PetProfileTagsView(tags: viewModel.pet?.specificTags ?? [])
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                PrimaryCollapsibleSection(title: "Что я ем") {
                    PetProfileDietView(
                        dietType: viewModel.pet?.dietType ?? "-",
                        dietPatterns: viewModel.pet?.dietPatterns ?? "-",
                        dietAdditionalInfo: viewModel.pet?.dietAdditionalInfo ?? "-"
                    )
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                PrimaryCollapsibleSection(title: "Важные предупреждения!") {
                    PetProfileTagsView(tags: viewModel.pet?.warningTags ?? [])
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
        .background(.primaryBackground)
        .scrollIndicators(.hidden)
        .task {
            await viewModel.fetchPet()
        }
        .ignoresSafeArea(edges: .top)
        .petProfileToolbar(onEdit: { openSettings(petId) })
    }
}

//#Preview {
//    PetProfileView(
//        repository: MockPetRepository(),
//        userStorage: UserStorage(),
//        petStorage: PetStorage(),
//        petId: 1,
//        openSettings: { id in }
//    )
//    .PreviewAppEnvironment()
//}
