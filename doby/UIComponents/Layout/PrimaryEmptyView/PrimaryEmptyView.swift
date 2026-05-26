import SwiftUI

struct PrimaryEmptyView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    let icon: String
    let title: String
    let description: String
    let buttonTitle: String
    let buttonIcon: String
    let action: () -> Void
 
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: icon)
                .font(.system(size: 64))
                .foregroundColor(primaryColorService.primaryColor.color)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
//                    .padding(.horizontal, 32)
            }
            
            PrimaryButton(
                title: buttonTitle,
                icon: buttonIcon,
                action: {
                    action()
                },
                size: .medium
            )
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
    }
}
