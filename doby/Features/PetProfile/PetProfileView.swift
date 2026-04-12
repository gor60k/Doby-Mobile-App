import SwiftUI

struct PetProfileView: View {
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    @StateObject private var viewModel = PetProfileViewModel()
    
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
                PetProfileLabelView(name: viewModel.pet.name, species: "Такса", age: viewModel.pet.age, gender: .male)
                
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
                            title: { $0.rawValue }
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                PrimaryCollapsibleSection(title: "Мои особенности") {
                    LazyVGrid(columns: grid, alignment: .leading, spacing: 10) {
                        ForEach(0..<5) { _ in
                            Text("Легко обучаюсь")
                                .frame(maxWidth: .infinity)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.secondary)
                                .padding(8)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(primaryColorService.currentColor.color, lineWidth: 1))
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                PrimaryCollapsibleSection(title: "Мое здоровье") {
                    Text("Здоровье")
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                PrimaryCollapsibleSection(title: "Что я ем") {
                    Text("Питание")
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                PrimaryCollapsibleSection(title: "Важные предупреждения!") {
                    Text("Я могу убежать")
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
        .background(.primaryBackground)
        .scrollIndicators(.hidden)
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    PetProfileView()
        .withAppEnvironment()
}
