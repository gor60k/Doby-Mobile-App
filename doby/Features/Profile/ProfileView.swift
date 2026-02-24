import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: AppRouter
    @State private var session = SessionService()
    
    @State private var viewModel = ProfileViewModel()
    private let userId = UUID()
    
    var body: some View {
        VStack {
            Button("Выйти", action: {
                session.removeKey("isRegistered")
                session.removeKey("isAuthenticated")
                router.push(.welcome)
            })
                .buttonStyle(.bordered)
            if viewModel.isLoading {
                ProgressView("Загрузка...")
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            else if let error = viewModel.errorMessage {
                Text("Ошибка: \(error)")
                    .foregroundColor(.red)
            }
            
            else if let user = viewModel.user {
                VStack {
                    Text(user.name)
                    Text(user.id.uuidString)
                }
            }
            
            else {
                Text("Нет данных пользователя")
            }
        }
    }
}
