import SwiftUI

struct PetProfileScreen: View {
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
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let pet):
                PetProfileContentView(
                    pet: pet,
                    currentPage: $viewModel.currentPage,
                    infoItems: viewModel.infoItems,
                    selection: $selection,
                    options: options
                )
            case .failed(let string):
                Text(string)
            }
        }
        .background(.primaryBackground)
        .scrollIndicators(.hidden)
        .refreshable {
            await viewModel.fetchPet()
        }
        .task {
            await viewModel.fetchPet()
        }
        .ignoresSafeArea(edges: .top)
        .petProfileToolbar(onEdit: { openSettings(petId) })
    }
}

//#Preview {
//    NavigationStack {
//        PetProfileScreen(
//            viewModel: .mock,
//            petId: 1,
//            openSettings: {_ in }
//        )
//    }
//    .PreviewAppEnvironment()
//}
