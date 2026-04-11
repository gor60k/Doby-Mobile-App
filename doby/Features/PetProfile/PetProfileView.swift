import SwiftUI

struct PetProfileView: View {
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    @StateObject private var viewModel = PetViewModel()
    
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
                ZStack {
                    VStack {
                        PrimarySlider(
                            currentPage: $viewModel.currentPage,
                            items: viewModel.slides,
                        ) { slide in
                            Image(slide.image)
                                .resizable()
                                .scaledToFill()
                        }
                    }
                    
                    HStack {
                        Text("\(viewModel.currentPage + 1) / \(viewModel.slides.count)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(.black.opacity(0.5))
                            .clipShape(Capsule())
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                
                HStack(spacing: 8) {
                    VStack(alignment: .leading) {
                        Text("Бобик")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Text("Корги")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Text("2 года")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    Text("♀")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(RoundedRectangle(cornerRadius: 12).fill(primaryColorService.currentColor.color))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .glassEffect(
                    .regular,
                    in: RoundedRectangle(cornerRadius: 16)
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .zIndex(1)
                
                PrimaryCollapsibleSection(title: "Подробнее") {
                    VStack(spacing: 10) {
                        HStack(spacing: 8) {
                            VStack(alignment: .leading) {
                                Text("Вес")
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(.secondary)
                                Text("6 кг")
                                    .font(.system(.headline, design: .rounded))
                                    .foregroundColor(primaryColorService.currentColor.color)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16).fill(primaryColorService.currentColor.color.opacity(0.1))
                            )
                            
                            VStack(alignment: .leading) {
                                Text("Высота")
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(.secondary)
                                Text("20 см")
                                    .font(.system(.headline, design: .rounded))
                                    .foregroundColor(primaryColorService.currentColor.color)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16).fill(primaryColorService.currentColor.color.opacity(0.1))
                            )
                            
                            VStack(alignment: .leading) {
                                Text("Цвет")
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(.secondary)
                                Text("Белый")
                                    .font(.system(.headline, design: .rounded))
                                    .foregroundColor(primaryColorService.currentColor.color)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16).fill(primaryColorService.currentColor.color.opacity(0.1))
                            )
                        }
                        
                        PetDetailsView(
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
