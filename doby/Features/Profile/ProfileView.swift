import SwiftUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    private let userId = UUID()
    
    var body: some View {
        VStack {
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
