import SwiftUI

struct RoleView: View {
    @State private var navigateNext: Bool = false
    @StateObject private var viewModel = RoleAccordionViewModel()
    @State private var showAuth = false
    @FocusState private var isPhoneFocused: Bool
    
    private let formatter = PhoneFormatter(defaultRegion: "RU")
    
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
                                PrimaryButton(title: "Продолжить", isEnabled: true) {
                                    viewModel.selectRole(item.roleValue)
                                    showAuth = true
                                }
                                .sheet(isPresented: $showAuth) {
                                    if let role = viewModel.selectedRole {
                                        AuthView(content: {
                                            Group {
                                                if role == "SITTER" {
                                                    SitterRegistrationView(selecteRole: role)
                                                } else {
                                                    OwnerRegistrationView(selectedRole: role)
                                                }
                                            }
                                        })
                                        .background(.primaryYellowLight)
                                        .presentationDetents([.large])
                                        .presentationDragIndicator(.visible)
                                    } else {
                                        Text("какашка")
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }

    }
}

#Preview {
    RoleView()
}
