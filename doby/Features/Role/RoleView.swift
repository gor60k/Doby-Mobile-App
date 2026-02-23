import SwiftUI

struct RoleView: View {
    @EnvironmentObject private var router: AppRouter
    
    @StateObject private var viewModel = RoleAccordionViewModel()
    @State private var session = SessionService()
    
    @FocusState private var isPhoneFocused: Bool
    
    @State private var navigateNext: Bool = false
    @State private var showAuth = false
    @State private var phone = ""
    
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
                            RoleAccordionView(item: item) {
                                PrimaryButton(title: "Продолжить", isEnabled: true, action: {
                                    session.selectedRole = item.roleValue
                                    router.push(.auth)
                                })
                            }
                        }
                    }
                    .padding()
                }
            }
    }
}
