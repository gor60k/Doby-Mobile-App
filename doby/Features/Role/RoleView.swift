import SwiftUI

struct RoleView: View {
    @EnvironmentObject private var router: AppRouter
    
    @StateObject private var viewModel = RoleViewModel()
    
    @FocusState private var isPhoneFocused: Bool
    
    @State private var session = SessionService()
    
    var body: some View {
            VStack {
                HeaderView(
                    title: "Выбор роли",
                    subtitle: "Выберите вашу роль ниже",
                    titleStyle: AppTextStyle.Presets.largeTitleBold,
                    subtitleStyle: AppTextStyle.Presets.headlineMedium
                )
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.accordionItems) { item in
                            PrimaryDisclosureView(
                                title: item.title,
                                headlineIcon: item.systemImage,
                                description: item.description
                            ) {
                                PrimaryButton(title: "Продолжить", isEnabled: true, action: {
                                    viewModel.selectRole(item.role ?? .owner)
                                    router.push(.auth)
                                })
                            }
                            .foregroundColor(.primaryYellow)
                            .glassEffect(
                                .regular.tint(.primaryYellowLight).interactive(),
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                        }
                    }
                    .padding()
                }
            }
    }
}
