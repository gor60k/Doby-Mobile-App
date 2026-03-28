import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: AppRouter
    
    @State private var viewModel = ProfileViewModel()
    @State private var authViewModel = AuthViewModel()
    
    private var session = SessionService.shared
    
    var body: some View {
        VStack {
            
            Text((session.currentUser?.username) ?? "")
            
            Button("Выйти", action: {
                SessionService.shared.removeKey("isAuthenticated")
                router.popToRoot()
            })
                .buttonStyle(.bordered)
            
            Button("Удалить профиль", action: {
                Task {
                    await authViewModel.delete()
                    
                    if authViewModel.errorMessage == nil {
                        await MainActor.run {
                            router.popToRoot()
                        }
                    }
                }
            })
            .buttonStyle(.bordered)
        }
    }
}
