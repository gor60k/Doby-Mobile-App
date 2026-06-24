import SwiftUI

extension View {
    
    @MainActor
    func PreviewAppEnvironment() -> some View {
        appEnvironment(
            container: try! AppContainer(),
            themeService: ThemeService(),
            primaryColorService: PrimaryColorService(),
            viewContextService: ViewContextService()
        )
    }

    @MainActor
    func appEnvironment(
        container: AppContainer,
        themeService: ThemeService,
        primaryColorService: PrimaryColorService,
        viewContextService: ViewContextService
    ) -> some View {
        self
            .environment(\.appContainer, container)
        
            .environment(container.petStorage)
            .environment(container.userStorage)
            .environment(container.cityStorage)
            .environment(container.chatStorage)
        
            .environment(container.sessionService)
            .environment(container.viewContextService)
        
            .environment(themeService)
            .environment(primaryColorService)
        
            .preferredColorScheme(themeService.colorScheme)
    }
}

struct LoadingPlaceholder: ViewModifier {
    let isLoading: Bool

    @State private var shimmerOffset: CGFloat = -1

    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.secondarySystemBackground))
                        .overlay {
                            GeometryReader { proxy in
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        .white.opacity(0.18),
                                        .clear
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(width: proxy.size.width * 0.35)
                                .offset(x: proxy.size.width * shimmerOffset)
                            }
                            .clipped()
                        }
                        .onAppear {
                            shimmerOffset = -1
                            withAnimation(
                                .linear(duration: 1.4)
                                    .repeatForever(autoreverses: false)
                            ) {
                                shimmerOffset = 2
                            }
                        }
                        .onDisappear {
                            shimmerOffset = -1
                        }
                }
            }
//            .opacity(isLoading ? 0 : 1)
    }
}

extension View {
    func loadingPlaceholder(isLoading: Bool) -> some View {
        modifier(LoadingPlaceholder(isLoading: isLoading))
    }
}
