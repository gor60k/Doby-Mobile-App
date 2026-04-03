import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: AppRouter
    
    @StateObject private var viewModel = ProfileViewModel()
    @State private var authViewModel = AuthViewModel()
    
    private var session = SessionService.shared
    
    @State private var selection = "Обо мне"
    let options = ["Обо мне", "Отзывы"]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                VStack(spacing: 10) {
                    let username = session.currentUser?.username
                    let firstName = session.currentUser?.first_name
                    let lastName = session.currentUser?.last_name
                    
                    Image("ProfileAvatarPlaceholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    if let firstName = firstName, !firstName.isEmpty {
                        HStack {
                            Text(firstName)
                            Text(lastName ?? "")
                        }
                    } else if let username = username, !username.isEmpty {
                        Text(username)
                            .style(AppTextStyle.Presets.titleSemibold)
                    } else {
                        Text("Хвостик-\(session.currentUser?.uuid)")
                    }
                    
                }
                
                VStack(alignment: .leading) {
                    Text("Мои услуги")
                        .style(AppTextStyle.Presets.captionRegular)
                    Divider()
                }
                
                VStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { service in
                        ProfileServiceButton(serviceTitle: "Выгул", servicePrice: "1000", action: {})
                    }
                }

                Divider()
                
                Picker("Выберите", selection: $selection) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(.segmented)

                VStack(alignment: .leading) {
                    if selection == "Обо мне" {
                        Text("Привет, я люблю 42🙏❤️")
                            .style(AppTextStyle.Presets.labelBold)
                        Text("Слава Богу 42🙏❤️СЛАВА 42🙏❤️АНГЕЛА ХРАНИТЕЛЯ 42 КАЖДОМУ ИЗ ВАС🙏❤️БОЖЕ ХРАНИ 42🙏❤️СПАСИБО ВАМ НАШИ БРАТУХИ🙏🏼❤️ХРАНИ БОсса💯Слава Богу 42🙏❤️СЛАВА 42🙏❤️АНГЕЛА ХРАНИ Слава Богу 42🙏❤️СЛАВА 42🙏❤️")
                            .style(AppTextStyle.Presets.bodyRegular)
                        
                    } else if selection == "Отзывы" {
                        VStack(spacing: 10) {
                            ForEach(0..<3, id: \.self) { _ in
                                PrimaryFeedback()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)

            VStack {
                Button(action: {router.push(.settings)}) {
                    Text("Изм.")
                        .style(AppTextStyle.Presets.bodySemibold)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .glassEffect(
                    .regular
                        .interactive()
                )
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.primaryBackground)
    }
}

#Preview {
    ProfileView()
}
