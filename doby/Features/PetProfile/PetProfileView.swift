import SwiftUI

struct PetProfileView: View {
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    @State private var viewModel: PetProfileViewModel
    
    let petId: Int
    
    init(petId: Int) {
        self.petId = petId
        _viewModel = State(initialValue: PetDIContainer.shared.makePetProfileViewModel())
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
                            title: { $0.rawValue }
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                PrimaryCollapsibleSection(title: "Мои особенности") {
                    LazyVGrid(columns: grid, alignment: .leading, spacing: 10) {
                        ForEach(viewModel.pet?.specificTags ?? [], id: \.self) { tag in
                            Text(tag)
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
                
                PrimaryCollapsibleSection(title: "Что я ем") {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Тип питания")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text(viewModel.pet?.dietType ?? "-")
                                .font(.system(.body, design: .rounded))
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Пищевые привычки")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text(viewModel.pet?.dietPatterns ?? "-")
                                .font(.system(.body, design: .rounded))
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Дополнительная информация")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text(viewModel.pet?.dietAdditionalInfo ?? "-")
                                .font(.system(.body, design: .rounded))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                PrimaryCollapsibleSection(title: "Важные предупреждения!") {
                    LazyVGrid(columns: grid, alignment: .leading, spacing: 10) {
                        ForEach(viewModel.pet?.warningTags ?? [], id: \.self) { tag in
                            Text(tag)
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
    PetProfileView(petId: 0)
        .withAppEnvironment()
}
