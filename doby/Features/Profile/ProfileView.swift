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
                VStack(spacing: 16) {
                    let username = session.currentUser?.username
                    
                    Image("ProfileAvatarPlaceholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Text(
                        (username?.isEmpty == false)
                        ? username!
                        : "Хвостик-\(session.currentUser?.id ?? 0)"
                    )
                    .style(AppTextStyle.Presets.titleBold)
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

                VStack {
                    if selection == "Обо мне" {
                        Text("Описание пользователя")
                        
                    } else if selection == "Отзывы" {
                        Text("Отзывы")
                    }
                }
                
                Divider()
            }
            .padding(.horizontal)

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
