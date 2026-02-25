import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var router: AppRouter
    private var session = SessionService.shared
    
    var body: some View {
        VStack {
            PrimaryButton(title: "Войти", isEnabled: true, action: {
                session.isAuthenticated = true
                router.push(.rootTab)
            })
        }
    }
}
