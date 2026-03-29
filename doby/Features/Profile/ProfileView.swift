import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: AppRouter
    
    @State private var viewModel = ProfileViewModel()
    @State private var authViewModel = AuthViewModel()
    
    private var session = SessionService.shared
    
    var body: some View {
        VStack {
            VStack {
                TabView {
                    ForEach(0..<3, id: \.self) { _ in
                        Image("ProfileAvatarPlaceholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .frame(maxWidth: .infinity, maxHeight: 300)
                .ignoresSafeArea()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -61, trailing: 0))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text((session.currentUser?.username) ?? "Username")
                        .style(AppTextStyle.Presets.titleBold)
                    
                    Text("Мне 42 года и я очень люблю маленьких собачек")
                    
                    Divider()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    ProfileView()
}
