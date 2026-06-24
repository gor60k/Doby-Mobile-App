import SwiftUI

struct PrimaryEmptyView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    @Environment(ViewContextService.self) private var viewContextService
    
    let icon: String
    let title: String
    let description: String
    let buttonTitle: String
    let buttonIcon: String
    let action: () -> Void
 
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()
            
            Image(systemName: icon)
                .font(.system(size: 64))
                .foregroundColor(primaryColorService.primaryColor.color)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                if viewContextService.isCurrentUser {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            
            if viewContextService.isCurrentUser {
                PrimaryButton(
                    title: buttonTitle,
                    icon: buttonIcon,
                    action: {
                        action()
                    },
                    size: .medium
                )
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack(alignment: .center) {
        PrimaryEmptyView(
            icon: "person.fill",
            title: "Title",
            description: "Description",
            buttonTitle: "Button",
            buttonIcon: "pencil.fill",
            action: {}
        )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    .PreviewAppEnvironment()
}
