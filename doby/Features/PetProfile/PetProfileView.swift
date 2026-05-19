import SwiftUI

struct PetProfileView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    @State private var viewModel: PetProfileViewModel
    let petId: Int
    
    init(
        repository: PetRepositoryProtocol,
        userStorage: UserStorageProtocol,
        petStorage: PetStorageProtocol,
        petId: Int
    ) {
        self.petId = petId
        _viewModel = State(initialValue: PetProfileViewModel(
            repository: repository,
            userStorage: userStorage,
            petStorage: petStorage,
            petId: petId
        ))
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
    }
}

#Preview {
    PetProfileView(
        repository: MockPetRepository(),
        userStorage: UserStorage(),
        petStorage: MockPetStorage(),
        petId: 1
    )
    .PreviewAppEnvironment()
}
