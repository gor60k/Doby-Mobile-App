import SwiftUI

struct AuthView: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    private let session = SessionService.shared
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            SignInView()
                .sheet(isPresented: $isPresented) {
                    NavigationStack {
                        SignUpView()
                            .toolbar {
                                ToolbarItem(placement: .topBarLeading) {
                                    Button("Назад", systemImage: "chevron.left") {
                                        isPresented = false
                                    }
                                }
                            }
                    }
                    .presentationDetents([.large])
                }
        }
        .overlay(alignment: .bottom) {
            AuthBottomBarView(isPresented: $isPresented)
                .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .background(.primaryBackground)
    }
}

#Preview {
    AuthView()
        .withAppEnvironment()
}
