import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: AppRouter
    
    @State private var viewModel = ProfileViewModel()
    private let userId = UUID()
    
    var body: some View {
        VStack {
            Button("Выйти", action: {
                SessionService.shared.removeKey("isAuthenticated")
                router.popToRoot()
            })
                .buttonStyle(.bordered)
            
            Button("Удалить профиль", action: {
                SessionService.shared.removeKey("isRegistered")
                SessionService.shared.removeKey("isAuthenticated")
                router.popToRoot()
            })
                .buttonStyle(.bordered)
        }
    }
}
