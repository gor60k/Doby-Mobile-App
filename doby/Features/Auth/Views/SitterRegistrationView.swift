import SwiftUI
import PhoneNumberKit

struct SitterRegistrationView: View {
    @EnvironmentObject private var router: AppRouter
    private let session = SessionService.shared
    
    var body: some View {
        VStack {
            Text("sitter reg")
            PrimaryButton(
                title: "Зарегистрироваться",
                isEnabled: true,
                action: {
                    session.isRegistered = true
                    router.push(.rootTab)
                }
            )
        }
        .padding()
    }
}
